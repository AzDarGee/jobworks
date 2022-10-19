# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)




# require 'uri'
# require 'net/http'
# require 'json'

# # Remotiv API
# uri = URI('https://remotive.io/api/remote-jobs?limit=100')
# res = Net::HTTP.get_response(uri)
# jobs = JSON.parse(res.body)["jobs"]

# if res.is_a?(Net::HTTPSuccess)
#   user = User.find(1)
#   if user.is_admin
#     jobs.each_with_index do |job, index|
#       new_job = user.jobs.new
#       if !job['company_logo_url'].nil?
#         url = URI.parse(job['company_logo_url'])
#         filename = File.basename(url.path)
#         file = URI.open(url)
#         new_job.company_logo.attach(io: file, filename: filename)
#       end
#       new_job.images.attach(io: File.open("#{Rails.root}/app/assets/images/computer-desk.jpeg"), filename: "computer-desk")
#       new_job.title = job['title']
#       new_job.url = job['url']
#       new_job.job_author = job['company_name']
#       new_job.industry = job['category'].capitalize
#       new_job.tags = job['tags']
#       if job['job_type'] != ""
#         new_job.job_type = job['job_type']
#       else
#         new_job.job_type = "N/A"
#       end
#       new_job.created_at = job['publication_date']
#       if job['candidate_required_location'] != ""
#         new_job.location = job['candidate_required_location']
#       else
#         new_job.location = "N/A"
#       end
#       new_job.remote_ok = false
#       if job['candidate_required_location'] == 'Remote'
#         new_job.remote_ok = true
#       end
#       if !job['salary'].empty?
#         new_job.salary_range = job['salary']
#       else
#         new_job.salary_range = Job::SALARY_RANGE[0]
#       end
#       new_job.description = job['description'].to_s
#       new_job.tag_list = job['tags']
#       new_job.start_date = Time.now + 14.days
#       new_job.apply_url = job['url']
#       new_job.num_employees = Job::NUM_EMPLOYEES[1]
#       new_job.status = "Active"
#       new_job.save!

#       puts "#{index}: #{job['title']} : Done \n"
#     end
#   end
# end


# Jooble API
# url = 'https://jooble.org/api/'
# key = '305c58b8-7433-4355-9d8d-ba469eb1af79'
# #create uri for request
# uri = URI.parse(url + key)
# #prepare post data
# post_args = { 'keywords': 'it', 'location': 'Bern'}
# #send request to the server
# http = Net::HTTP.new(uri.host, uri.port)
# #for https
# http.use_ssl = true
# request = Net::HTTP::Post.new(uri.request_uri, 'Content-Type' => 'application/json')
# request.body = post_args.to_json
# #send request to the server
# response = http.request(request)
