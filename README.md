# ORMBr Framework for Delphi

Versão mantida por Andrews Bejatto.

## 🏛 Delphi Versions
Embarcadero Delphi XE e superior.

## ⚙️ Instalação
Instalação usando o [`boss install`]
```sh
boss install "https://github.com/HashLoad/ormbr"
```

## ⚠ Dependências

:heavy_check_mark: [DBCBr Framework for Delphi](https://github.com/hashload/dbcbr)

:heavy_check_mark: [DBEBr Framework for Delphi/Lazarus](https://github.com/hashload/dbebr)

:heavy_check_mark: [CQLBr Framework for Delphi/Lazarus](https://github.com/hashload/cqlbr)

:heavy_check_mark: [JSONBr Framework for Delphi](https://github.com/hashload/jsonbr)

## ⚡️ Como usar
```Delphi
unit ormbr.model.client;

interface

uses
  Classes, 
  DB, 
  SysUtils, 
  Generics.Collections, 
  /// orm 
  dbcbr.mapping.attributes,
  ormbr.types.nullable,
  dbcbr.types.mapping,
  dbcbr.mapping.register,
  ormbr.types.blob;

type
  [Entity]
  [Table('client','')]
  [PrimaryKey('client_id', 'Chave primária')]
  [Indexe('idx_client_name','client_name')]
  [OrderBy('client_id Desc')]
  Tclient = class
  private
    { Private declarations }
    Fclient_id: Integer;
    Fclient_name: String;
    Fclient_foto: TBlob;
  public
    { Public declarations }
    [Restrictions([NoUpdate, NotNull])]
    [Column('client_id', ftInteger)]
    [Dictionary('client_id','Mensagem de validação','','','',taCenter)]
    property client_id: Integer read Fclient_id write Fclient_id;

    [Column('client_name', ftString, 40)]
    [Dictionary('client_name','Mensagem de validação','','','',taLeftJustify)]
    property client_name: String read Fclient_name write Fclient_name;

    [Column('client_foto', ftBlob)]
    [Dictionary('client_foto','Mensagem de validação')]
    property client_foto: TBlob read Fclient_foto write Fclient_foto;
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(Tclient);

end.
```

```Delphi
unit uMainFormORM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  DB, Grids, DBGrids, StdCtrls, Mask, DBClient, DBCtrls, ExtCtrls,

  // ORMBr
  dbebr.factory.interfaces,
  ormbr.container.dataset.interfaces,
  ormbr.container.fdmemtable,
  dbebr.factory.firedac,
  ormbr.dml.generator.sqlite,
  ormbr.model.client,

  // FireDAC, caso esteja usando ele
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Comp.Client, FireDAC.Stan.Intf,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Comp.UI, FireDAC.DApt, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.Phys.SQLiteWrapper.Stat;

type
  TForm3 = class(TForm)
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Button2: TButton;
    FDConnection1: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDClient: TFDMemTable;
    DataSource1: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FDClientAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
    // Interface de conexão do ORMBr
    FConn: IDBConnection;
    // Interface para acontrolar o DataSet
    FContainerClient: IContainerDataSet<Tclient>;
public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses
  StrUtils;

{$R *.dfm}

procedure TForm3.Button2Click(Sender: TObject);
begin
  FContainerClient.ApplyUpdates(0);
end;

procedure TForm3.FDClientAfterInsert(DataSet: TDataSet);
var
  ID: TGUID;
begin
  FDClient.FieldByName('client_id').AsString := GUIDToString(ID);
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  // Instância da class de conexão via FireDAC
  FConn := TFactoryFireDAC.Create(FDConnection1, dnSQLite);
  // Client
  FContainerClient := TContainerFDMemTable<Tclient>.Create(oConn, FDClient);

  FContainerClient.Open;
end;

end.
```

```Delphi
...

procedure TForm3.FormCreate(Sender: TObject);
begin
  // Instância da class de conexão via FireDAC
  FConn := TFactoryFireDAC.Create(FDConnection1, dnMySQL);

  FManager := TManagerDataSet.Create(oConn);
  FConn.SetCommandMonitor(TCommandMonitor.GetInstance);
  FManager.AddAdapter<Tmaster>(FDMaster, 3)
          .AddAdapter<Tdetail, Tmaster>(FDDetail)
          .AddAdapter<Tclient, Tmaster>(FDClient)
          .AddAdapter<Tlookup>(FDLookup)
          .AddLookupField<Tdetail, Tlookup>('fieldname',
                                            'lookup_id',
                                            'lookup_id',
                                            'lookup_description',
                                            'Descrição Lookup');
  FManager.Open<Tmaster>;
end;
```

## ✍️ License
[![License](https://img.shields.io/badge/Licence-LGPL--3.0-blue.svg)](https://opensource.org/licenses/LGPL-3.0)

## ⛏️ Contribuição

Nossa equipe adoraria receber contribuições para este projeto open source. Se você tiver alguma ideia ou correção de bug, sinta-se à vontade para abrir uma issue ou enviar uma pull request.

[![Issues](https://img.shields.io/badge/Issues-channel-orange)](https://github.com/HashLoad/ormbr/issues)

Para enviar uma pull request, siga estas etapas:

1. Faça um fork do projeto
2. Crie uma nova branch (`git checkout -b minha-nova-funcionalidade`)
3. Faça suas alterações e commit (`git commit -am 'Adicionando nova funcionalidade'`)
4. Faça push da branch (`git push origin minha-nova-funcionalidade`)
5. Abra uma pull request

## 📬 Contato
[![Telegram](https://img.shields.io/badge/Telegram-channel-blue)](https://t.me/hashload)

## 💲 Doação
[![Doação](https://img.shields.io/badge/PagSeguro-contribua-green)](https://pag.ae/bglQrWD)
