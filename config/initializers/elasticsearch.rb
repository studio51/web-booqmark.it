Searchkick.client = Elasticsearch::Client.new(hosts: ['10.0.1.20:9200', '10.0.1.20:9201'], retry_on_failure: true)
