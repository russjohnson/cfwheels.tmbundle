require 'cfml_bundle_tools'

current_path = ENV['TM_DIRECTORY']


# If text is selected, create a partial out of it
if TextMate.selected_text
  partial_name = TextMate::UI.request_string(
    :title => "Create a partial from the selected text", 
    :default => "partial",
    :prompt => "Name of the new partial: (omit the _ and .cfm)",
    :button1 => 'Create'
  )

  if partial_name
    path = current_path
    partial = File.join(path, "_#{partial_name}.cfm")

    # Create the partial file
    if File.exist?(partial)
      unless TextMate::UI.request_confirmation(
        :button1 => "Overwrite",
        :button2 => "Cancel",
        :title => "The partial file already exists.",
        :prompt => "Do you want to overwrite it?"
      )
        TextMate.exit_discard
      end
    end

    file = File.open(partial, "w") { |f| f.write(TextMate.selected_text) }
    TextMate.rescan_project

    # Return the new render :partial line
    print "\#includePartial('#{partial_name}')#\n"
  else
    TextMate.exit_discard
  end
else
	TextMate.exit_show_tool_tip("You have to select the text to create a partial from.")
	TextMate.exit_replace_document
end