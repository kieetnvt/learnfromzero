require "googleauth"
require "pry"

credentials = Google::Auth::UserRefreshCredentials.new(
  client_id: "793055034112-qqof8tbsmf0go2vaffsi39jertoo59sf.apps.googleusercontent.com",
  client_secret: "3dWPKAlOlGE1fuUvFYE_V-sR",
  scope: [
    "https://www.googleapis.com/auth/drive",
    "https://spreadsheets.google.com/feeds/",
  ],
  redirect_uri: "http://example.com/redirect")

auth_url = credentials.authorization_uri

# http://example.com/redirect?code=4/vQE4jw7QSngv_kuA-CXeZPh8aU1oEtHUG93Wftb09bxkoDIGJ5j_bfp_kzN7-nal2-5gPIr-Gv4W7Np8JbjXLY0&scope=https://www.googleapis.com/auth/drive%20https://www.googleapis.com/auth/spreadsheets
# authorization_code = "4/vQE4jw7QSngv_kuA-CXeZPh8aU1oEtHUG93Wftb09bxkoDIGJ5j_bfp_kzN7-nal2-5gPIr-Gv4W7Np8JbjXLY0"

credentials.code = authorization_code
credentials.fetch_access_token!

session = GoogleDrive::Session.from_credentials(credentials)

# First worksheet of
# https://docs.google.com/spreadsheet/ccc?key=pz7XtlQC-PYx-jrVMJErTcg
# Or https://docs.google.com/a/someone.com/spreadsheets/d/pz7XtlQC-PYx-jrVMJErTcg/edit?usp=drive_web
ws = session.spreadsheet_by_key("1fvRwrbSnk9O-mhTE4jLM1eeBwtrP1HHgzDbNY98FQ4s").worksheets[0]

# Gets content of A2 cell.
p ws[2, 1]  #==> "hoge"

# Changes content of cells.
# Changes are not sent to the server until you call ws.save().
# ws[2, 1] = "foo"
# ws[2, 2] = "bar"
# ws.save

# Dumps all cells.
(1..ws.num_rows).each do |row|
  (1..ws.num_cols).each do |col|
    p ws[row, col]
  end
end

# Yet another way to do so.
p ws.rows  #==> [["fuga", ""], ["foo", "bar]]

# Reloads the worksheet to get changes by other clients.
ws.reload