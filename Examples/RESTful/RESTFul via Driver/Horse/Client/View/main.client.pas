unit main.client;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  System.TypInfo,
  Data.DB,
  Vcl.Grids,
  Vcl.DbGrids,
  Vcl.StdCtrls,
  Vcl.Mask,
  Datasnap.DBClient,
  Vcl.DBCtrls,
  Vcl.ExtCtrls,
  System.Generics.Collections,

  controller.master,
  ormbr.client.methods,

  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFormClient = class(TForm)
    dtsMaster: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Button2: TButton;
    DBGrid2: TDBGrid;
    dtsDetail: TDataSource;
    dtsClient: TDataSource;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    Label8: TLabel;
    DBEdit7: TDBEdit;
    DBImage1: TDBImage;
    Button3: TButton;
    Memo1: TMemo;
    Button4: TButton;
    Label9: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FController: TControllerMaster;
  public
    { Public declarations }
  end;

var
  FormClient: TFormClient;

implementation

uses
  provider.datamodule;

{$R *.dfm}

procedure TFormClient.Button2Click(Sender: TObject);
begin
  FController.ApplyUpdates;
end;

procedure TFormClient.Button3Click(Sender: TObject);
begin
  FController.MonitorShow;
end;

procedure TFormClient.Button4Click(Sender: TObject);
begin
  Memo1.Text := FController.Execute('http://localhost:9000/ping', TRESTRequestMethodType.rtGET,
                                    procedure
                                    begin
                                      FController.ProviderDM.RESTClientHorse1.AddParam('ID = 7');
                                    end);
end;

procedure TFormClient.FormCreate(Sender: TObject);
begin
  FController := TControllerMaster.Create;
  // Linka os datasets em runtime para garantir que não perca link em designer
  dtsMaster.DataSet := FController.Master;
  dtsDetail.DataSet := FController.Detail;
  dtsClient.DataSet := FController.Client;
  //
  FController.Open;
end;

procedure TFormClient.FormDestroy(Sender: TObject);
begin
  FController.Free;
  inherited;
end;

end.
