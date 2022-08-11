1. Design the Route Signature
You'll need to include:

# Request:
POST /albums

# With body parameters:
title=Voyage
release_year=2022
artist_id=2

# Expected response (200 OK)
(No content)

2. Design the Response
The route might return different responses, depending on the result.

For example, a route for a specific blog post (by its ID) might return 200 OK if the post exists, but 404 Not Found if the post is not found in the database.

Your response might return plain text, JSON, or HTML code.

Replace the below with your own design. Think of all the different possible responses your route will return.

<!-- EXAMPLE -->
<!-- Response when the post is found: 200 OK -->

<html>
  <head></head>
  <body>
    <h1>Post title</h1>
    <div>Post content</div>
  </body>
</html>
<!-- EXAMPLE -->
<!-- Response when the post is not found: 404 Not Found -->

<html>
  <head></head>
  <body>
    <h1>Sorry!</h1>
    <div>We couldn't find this post. Have a look at the homepage?</div>
  </body>
</html>

3. Write Examples
Replace these with your own design.

# Request:

POST /albums

# Expected response: (no content)

Response for 404 Not Found

4. Encode as Tests Examples
# EXAMPLE
# file: spec/integration/application_spec.rb

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "POST /albums" do
    it 'returns 200 OK' do
      # Assuming the post with id 1 exists.
      response = post('/albums', title: 'Voyage', release_year: 2022, artist_id: 2)

      expect(response.status).to eq(200)
      #expect(response.body).to eq(expected_response)
    end

    it 'returns 404 Not Found' do
      response = post('/albums')

      expect(response.status).to eq(404)
      #expect(response.body).to eq(expected_response)
    end
  end
end
5. Implement the Route
Write the route and web server code to implement the route behaviour.

