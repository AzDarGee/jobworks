# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Remotiv API

require 'uri'
require 'net/http'
require 'json'

uri = URI('https://remotive.io/api/remote-jobs')
res = Net::HTTP.get_response(uri)
jobs = JSON.parse(res.body)["jobs"]

if res.is_a?(Net::HTTPSuccess)
  user = User.find(6)
  if user.is_admin
    jobs.each_with_index do |job, index|
      new_job = user.jobs.create(
        title: job['title'],
        url: job['url'],
        job_author: job['company_name'],
        industry: job['category'].capitalize,
        tags: job['tags'],
        job_type: job['job_type'],
        created_at: job['publication_date'],
        location: job['candidate_required_location'],
        remote_ok: false,
        salary_range: job['salary'],
        description: job['description'].to_s,
        tag_list: job['tags'],
        start_date: Time.now + 14.days,
        apply_url: job['url']
      )
      if !job['company_logo_url'].nil?
        url = URI.parse(job['company_logo_url'])
        filename = File.basename(url.path)
        file = URI.open(url)
        new_job.images.attach(io: file, filename: filename)
      end
      new_job.save
      # new_job = user.jobs.build
      # new_job.title = job['title']
      # new_job.url = job['url']
      # new_job.job_author = job['company_name']
      # new_job.industry = job['category'].capitalize
      # new_job.tags = job['tags']
      # new_job.job_type = job['job_type']
      # new_job.created_at = job['publication_date']
      # new_job.location = job['candidate_required_location']
      # new_job.remote_ok = false
      # if job['candidate_required_location'] == 'Remote'
      #   new_job.remote_ok = true
      # end
      # if !job['salary'].empty?
      #   new_job.salary_range = job['salary']
      # else
      #   new_job.salary_range = Job::SALARY_RANGE[0]
      # end
      # new_job.description = job['description'].to_s
      # if !job['company_logo_url'].nil?
      #   new_job.images.attach(io: job['company_logo_url'], filename: 'company_logo', content_type: 'image')
      # end
      # new_job.tag_list = job['tags']
      # new_job.start_date = Time.now + 14.days
      # new_job.apply_url = job['url']
      # # binding.pry
      # new_job.save

      puts "#{index}: #{job['title']} : Done \n"
    end
  end
end