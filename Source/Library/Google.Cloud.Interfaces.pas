unit Google.Cloud.Interfaces;

interface

uses
  System.TimeSpan,

  Grijjy.Bson,

  Google.Cloud.Types;

type
  ILogger = interface
    ['{B92CD011-B050-4814-A35A-5C564DD701AA}']
    procedure Log(const Text: String; const Severity: TLogSeverity = TLogSeverity.Info; const Timestamp: TDateTime = 0); overload;
    procedure Log(const Text: String; const Args: Array of const; const Severity: TLogSeverity = TLogSeverity.Info; const Timestamp: TDateTime = 0); overload;
  end;

  IHTTPResponse = interface
    ['{CE9116ED-584C-4E56-BF90-1F75676AC9B1}']
    function GetContent: String;
    function GetHeaders: String;
    procedure SetContent(const Value: String);
    procedure SetHeaders(const Value: String);
    function GetHTTPResponseCode: THTTPResponseCode;
    procedure SetHTTPResponseCode(const Value: THTTPResponseCode);
    function GetResponseTime: TTimeSpan;
    procedure SetResponseTime(const Value: TTimeSpan);
    property Headers: String read GetHeaders write SetHeaders;
    property Content: String read GetContent write SetContent;
    property HTTPResponseCode: THTTPResponseCode read GetHTTPResponseCode write SetHTTPResponseCode;
    property ResponseTime: TTimeSpan read GetResponseTime write SetResponseTime;
  end;

  IGoogleCloudService = interface
    ['{475452AE-F7D8-4816-A84B-6FEBB8AC5095}']
  end;

  IGoogleCloudAuthentication = interface(IGoogleCloudService)
    ['{760AA9A7-3590-4BCB-BE6D-643374321E31}']
    function GetAccessToken(const ServiceAccount, OAuthScope, PrivateKeyFilename: String; const ExpireSeconds: Cardinal): String;
    procedure ResetAccessToken;
  end;

  ISpeechSyncRecognizeResponse = interface(IHTTPResponse)

  end;

  IGoogleCloudSpeech = interface(IGoogleCloudService)
    ['{8849991C-4E9E-45E3-8052-E4D194B70B1E}']
    function SyncRecognize(
      const SpeechEncoding: String;
      const SampleRate: TSpeechSampleRate;
      const AudioURI: String;
      const LanguageCode: String = TLanguageCode.en_US;
      const MaxAlternatives: Integer = 1;
      const ProfanityFilter: Boolean = False): ISpeechSyncRecognizeResponse; overload;
    function SyncRecognize(
      const SpeechEncoding: String;
      const SampleRate: TSpeechSampleRate;
      const AudioURI: String;
      const LanguageCode: String;
      const MaxAlternatives: Integer;
      const ProfanityFilter: Boolean;
      const SpeechContext: TgoBsonDocument): ISpeechSyncRecognizeResponse; overload;
  end;

  IGoogleCloud = interface
    ['{7782625C-5964-48EE-B96E-28E7D6061B11}']
    procedure InitializeGoogleCloud(const ServiceAccount, OAuthScope, PrivateKey: String);
    function GetAccessToken: String;
    procedure SaveSettings(const Filename: String);
    procedure LoadSettings(const Filename: String);
    function GetServiceAccount: String;
    function GetOAuthScope: String;
    function GetPrivateKeyFilename: String;

    function Speech: IGoogleCloudSpeech;
  end;

implementation

end.