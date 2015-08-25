VCR.configure do |c|
  # The directory where your cassettes will be saved
  c.cassette_library_dir = 'spec/vcr'
  # Your HTTP request service. you can also use fakeweb, webmock, and more
  c.hook_into :webmock
end
