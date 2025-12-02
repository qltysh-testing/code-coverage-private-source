#!/usr/bin/env ruby
# frozen_string_literal: true

require 'fileutils'
require 'open3'
require 'optparse'
require 'securerandom'

class PullRequestGenerator
  TEMPLATE_LIB_DIR = 'lib/test1'
  TEMPLATE_SPEC_DIR = 'spec/test1'

  def initialize(count, coverage: true)
    @count = count
    @coverage = coverage
    @base_branch = current_branch
    @used_directories = []
  end

  def generate
    puts "Creating #{@count} pull requests..."
    
    @count.times do |i|
      number = find_next_available_number
      @used_directories << number
      create_pull_request(number, i)
    end
    
    checkout_branch(@base_branch)
    puts "\nAll pull requests created successfully!"
  end

  private

  def find_next_available_number
    number = 2  # Start from 2 since test1 is the template
    while Dir.exist?("lib/test#{number}") || @used_directories.include?(number)
      number += 1
    end
    number
  end

  def create_pull_request(number, index)
    # Use unique branch name for each PR
    timestamp = Time.now.to_i
    branch_name = "feature/test#{number}-pr#{index + 1}-#{timestamp}"
    dir_name = "test#{number}"
    
    puts "\n--- Creating PR ##{index + 1}: #{branch_name} ---"
    
    # Create and checkout new branch
    checkout_branch(@base_branch)
    run_command("git checkout -b #{branch_name}")
    
    # Copy template directories to new location
    copy_template_to_new_directory(dir_name)
    
    # Stage and commit changes
    run_command("git add .")
    module_name = "Test#{number}"
    unique_id = SecureRandom.hex(8)
    commit_message = "Add #{module_name} module with calculator functionality [#{unique_id}]"
    run_command("git commit -m \"#{commit_message}\"")
    
    # Push branch and create PR
    run_command("git push -u origin #{branch_name}")
    
    pr_body = if @coverage
                <<~BODY
                  ## Summary
                  - Added new #{module_name} module in lib/#{dir_name}
                  - Includes calculator functionality wrapped in module namespace
                  - Added comprehensive test coverage

                  ## Files Changed
                  - `lib/#{dir_name}/calculator#{number}.rb` - Module implementation
                  - `spec/#{dir_name}/calculator#{number}_spec.rb` - Test suite
                BODY
              else
                <<~BODY
                  ## Summary
                  - Added new #{module_name} module in lib/#{dir_name}
                  - Includes calculator functionality wrapped in module namespace

                  ## Files Changed
                  - `lib/#{dir_name}/calculator#{number}.rb` - Module implementation
                BODY
              end
    
    run_command("gh pr create --title \"Add #{module_name} module\" --body \"#{pr_body}\"")
    puts "Pull request created for #{branch_name}"
  end

  def copy_template_to_new_directory(dir_name)
    number = dir_name.gsub('test', '')
    
    # Copy lib template
    lib_dest_dir = "lib/#{dir_name}"
    FileUtils.mkdir_p(lib_dest_dir)
    
    # Read template file
    template_lib_file = Dir.glob("#{TEMPLATE_LIB_DIR}/*.rb").first
    template_content = File.read(template_lib_file)
    
    # Update module and class names
    updated_content = template_content.gsub('Test1', "Test#{number}")
                                     .gsub('Calculator1', "Calculator#{number}")
    
    # Write to new location
    dest_lib_file = "#{lib_dest_dir}/calculator#{number}.rb"
    File.write(dest_lib_file, updated_content)
    puts "Created file: #{dest_lib_file}"
    
    return unless @coverage

    # Copy spec template
    spec_dest_dir = "spec/#{dir_name}"
    FileUtils.mkdir_p(spec_dest_dir)

    # Read template spec file
    template_spec_file = Dir.glob("#{TEMPLATE_SPEC_DIR}/*.rb").first
    template_spec_content = File.read(template_spec_file)

    # Update references in spec
    updated_spec_content = template_spec_content.gsub('test1', dir_name)
                                                .gsub('Test1', "Test#{number}")
                                                .gsub('Calculator1', "Calculator#{number}")
                                                .gsub('calculator1', "calculator#{number}")

    # Write to new location
    dest_spec_file = "#{spec_dest_dir}/calculator#{number}_spec.rb"
    File.write(dest_spec_file, updated_spec_content)
    puts "Created spec: #{dest_spec_file}"
  end

  def current_branch
    stdout, = Open3.capture2("git branch --show-current")
    stdout.strip
  end

  def checkout_branch(branch)
    run_command("git checkout #{branch}")
  end

  def run_command(command)
    puts "  $ #{command}"
    stdout, stderr, status = Open3.capture3(command)
    
    unless status.success?
      puts "Error executing command: #{command}"
      puts "STDERR: #{stderr}"
      exit 1
    end
    
    stdout
  end
end

# Main execution
options = { coverage: true }

OptionParser.new do |opts|
  opts.banner = "Usage: ruby create_pull_requests.rb [options] <number_of_prs>"

  opts.on("--no-coverage", "Skip creating spec files (no test coverage)") do
    options[:coverage] = false
  end

  opts.on("-h", "--help", "Show this help message") do
    puts opts
    exit
  end
end.parse!

if ARGV.empty?
  puts "Usage: ruby create_pull_requests.rb [options] <number_of_prs>"
  puts "Use --help for more information"
  exit 1
end

count = ARGV[0].to_i
if count <= 0
  puts "Please provide a positive number of pull requests to create"
  exit 1
end

generator = PullRequestGenerator.new(count, coverage: options[:coverage])
generator.generate