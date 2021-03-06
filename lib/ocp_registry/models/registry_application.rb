
module Ocp::Registry::Models
  class RegistryApplication < Sequel::Model
  	def before_create
  		values[:id] = Ocp::Registry::Common.uuid
  		values[:created_at] = Time.now.utc.to_s
  		values[:state] = 'PENDING'
  	end

  	one_to_many :registry_settings, :select => [:id ,:comments, :settings, :updated_at, :from], :order => :version

  	def to_hash(opts = {})
  		hash = self.values
  		if false == opts[:lazy_load]
  			settings = []
  			self.registry_settings do |data|
          limit = opts[:limit]
          data = data.limit(limit) if limit
          data.reverse(:version).each do |set|
    				settings << set.to_hash
          end
  			end
  			hash[:registry_settings] = settings
  		end
  		Ocp::Registry::Common.deep_copy(hash)
  	end

  end
end