Given /^the following invoices:$/ do |invoices|
  Invoice.create!(invoices.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) invoice$/ do |pos|
  visit invoices_url
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following invoices:$/ do |expected_invoices_table|
  expected_invoices_table.diff!(tableish('table tr', 'td,th'))
end
