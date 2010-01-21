require 'cfml_bundle_tools'
require 'fileutils'

current_path = ENV['TM_DIRECTORY']

selection = TextMate::UI.request_string(
  :title => "Quick Migration Generator", 
  :default => "CreateUserTable",
  :prompt => "Name the new migration:",
  :button1 => 'Create'
)

project_root = ENV['TM_PROJECT_DIRECTORY']
migration_dir = File.join(project_root, "db", "migrate")
number = Time.now.utc.strftime("%Y%m%d%H%M%S")

generated_code = '<cfcomponent extends="plugins.dbmigrate.Migration" hint="">
  <cffunction name="up">
    <cfscript>
        
    </cfscript>
  </cffunction>
  <cffunction name="down">
    <cfscript>
    
    </cfscript>
  </cffunction>
</cfcomponent>'

FileUtils.mkdir_p migration_dir
new_migration_filename = File.join(migration_dir, number + "_" + selection + ".cfc")
File.open(new_migration_filename, "w") { |f| f.write generated_code }
TextMate.rescan_project
TextMate.open(new_migration_filename, 3, 9)