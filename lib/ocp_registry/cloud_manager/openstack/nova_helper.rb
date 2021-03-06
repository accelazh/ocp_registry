module Ocp::Registry

	class CloudManager

		class Openstack

			module NovaHelper

				NOVA_QUOTA_FIELDS = ["metadata_items",
				                     "cores",
				                     "instances",
				                     "injected_files",
				                     "injected_file_content_bytes",
				                     "ram",
				                     "floating_ips",
				                     "fixed_ips",
				                     "security_groups",
				                     "security_group_rules"]

				def default_compute_quota
					with_openstack { compute.get_quota_defaults(nil).body["quota_set"] }
				end

				def set_compute_quota(tenant_id, hash)
					with_openstack do 
						settings = Ocp::Registry::Common.hash_filter(hash, NOVA_QUOTA_FIELDS)
						compute.update_quota(tenant_id,settings).body["quota_set"]
					end
				end

			end

		end

	end

end
