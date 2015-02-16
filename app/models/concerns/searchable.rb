# module Searchable
#   extend ActiveSupport::Concern

#   Elasticsearch::Model.client = Elasticsearch::Client.new host: "http://#{ENV['ELASTICSEARCH_URL']}:9200"
#   Elasticsearch::Model.client = Elasticsearch::Client.new log: true

#   included do
#     include Elasticsearch::Model
#     include Elasticsearch::Model::Callbacks

#     # => 'booqmarkit_application_development'
#     #
#     index_name [Rails.application.engine_name, Rails.env].join('_')

#     settings index: { number_of_shards: 5, number_of_replicas: 1 } do
#       mappings dynamic: false do
#         indexes :name,        type: 'string', analyzer: 'keyword'
#         indexes :url,         type: 'string', analyzer: 'snowball'
#         indexes :description, type: 'text',   analyzer: 'snowball'
#         indexes :created_at,  type: 'date'
#         indexes :updated_at,  type: 'date'

#         indexes :collections do
#           indexes :name, type: 'multi_field' do
#             indexes :name
#             indexes :raw, analyzer: 'keyword'
#           end
#         end

#         indexes :users do
#           indexes :name, type: 'multi_field' do
#             indexes :name
#             indexes :raw, analyzer: 'keyword'
#           end
#         end

#         indexed = [:buildings, :client, :project_status, :project_types]

#         indexed.map do |i|
#           indexes i do
#             indexes :name, type: 'string', analyzer: 'keyword'
#           end
#         end
#       end
#     end

#     after_commit lambda { Indexer.perform_async(:index,  self.class.to_s, self.id) }, on: :create
#     after_commit lambda { Indexer.perform_async(:update, self.class.to_s, self.id) }, on: :update
#     after_commit lambda { Indexer.perform_async(:delete, self.class.to_s, self.id) }, on: :destroy
#     after_touch  lambda { Indexer.perform_async(:update, self.class.to_s, self.id) }

#     def as_indexed_json(options = {})
#       self.as_json({
#         only: [:name, :description, :created_at, :updated_at],

#         include: {
#           collections: {
#             only: [:id, :name]
#           },
#           users: {
#             methods: [:name],
#             only: [:name]
#           }
#         }
#       })
#     end

#     self.include_root_in_json = false

#     def self.search(query, options = {})

#       __set_filters = lambda do |key, f|

#         @definitions[:filter][:and] ||= []
#         @definitions[:filter][:and]  |= [f]

#         @definitions[:aggregations][key.to_sym][:filter][:and] ||= []
#         @definitions[:aggregations][key.to_sym][:filter][:and]  |= [f]
#       end

#       filters = [
#       ]

#       @definitions = {
#         query: {},

#         highlight: {
#           pre_tags: ['<i class="searchable-highlight">'],
#           post_tags: ['</i>'],
#           fields: {
#             name:        { number_of_fragments: 0 },
#             description: { number_of_fragments: 0 }
#           }
#         },

#         filter: {},

#         aggregations: {
#           users: {
#             filter: {},

#             aggregations: {
#               users: {
#                 terms: {
#                   field: 'users.name.raw'
#                 }
#               }
#             }
#           }
#         }
#       }

#       if query.blank?
#         @definitions[:query] = { match_all: {}}
#         @definitions[:sort]  = { created_at: 'desc' }
#       else
#         @definitions[:query] = {
#           bool: {
#             must: [
#               { simple_query_string: {
#                   query: query,
#                   analyzer: 'snowball',
#                   fields: [],
#                   default_operator: 'and'
#                 }
#               }
#             ]
#           }
#         }
#       end

#       filters.each do |f, term|
#         if options[f.to_s.singularize.to_sym]
#           a = {
#             term: {
#               "#{f.to_s}.#{term}" => options[f.to_s.singularize.to_sym]
#             }
#           }

#           filters.map { |set, term| __set_filters.(set, a) }
#         end
#       end

#       unless query.blank?
#         @definitions[:suggest] = {
#           text: query,
#           suggest_title: {
#             term: {
#               field: 'name',
#               suggest_mode: 'always'
#             }
#           },
#           suggest_body: {
#             term: {
#               field: 'description',
#               suggest_mode: 'always'
#             }
#           }
#         }
#       end

#       if options[:sort]
#         @definitions[:sort]  = {
#           options[:sort] => 'desc'
#         }

#         @definitions[:track_scores] = true
#       end

#       __elasticsearch__.search(@definitions)
#     end
#   end
# end
