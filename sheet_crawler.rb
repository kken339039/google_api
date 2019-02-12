require 'google/apis/sheets_v4'
require 'googleauth'

def get_data_from_google_sheet(config={})
  service = Google::Apis::SheetsV4::SheetsService.new
  service.authorization = get_google_auth

  values = service.get_spreadsheet_values(config[:sheet_id], config[:range]).values
  puts values
end

def get_google_auth
  scope = [Google::Apis::SheetsV4::AUTH_SPREADSHEETS_READONLY]
  file = File.open("./config/google_sheet_key.json", 'r')
  authorization = Google::Auth::ServiceAccountCredentials.make_creds({:json_key_io=> file, :scope => scope})
end

config = {
  sheet_id: "1VeIFxAzD-2c2mALmpn_xkiDvT1zT5vkwk6PqYEXWqMg",
  range: "!A1:B5000"
}

get_data_from_google_sheet(config)