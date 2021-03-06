require 'active_collab/task'

module ActiveCollab
	module API
		module Tasks

			def tasks(project_id)
				url = "#{@api_url}?path_info=/projects/#{project_id}/tasks&auth_api_token=#{@api_key}"
				response = HTTParty.get(url)
				response_tasks = response["tasks"].first[1]
				if response_tasks.kind_of?(Hash)
					tasks = [ActiveCollab::Task.from_hash(response_tasks)]
				else
					tasks = response_tasks.collect do |t|
						ActiveCollab::Task.from_hash(t)
					end
				end
				tasks
			end

			def add_task(project_id, task_options = {})
				url = "#{@api_url}?path_info=/projects/#{project_id}/tasks/add&auth_api_token=#{@api_key}"
				options = { body: {task: task_options, submitted: 'submitted'} }
				response = HTTParty.post(url, options)
				ActiveCollab::Task.from_hash(response["task"])
			end

		end
	end
end

 