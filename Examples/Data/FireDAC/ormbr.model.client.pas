unit ormbr.model.client;

interface

uses
  System.Classes, 
  Data.DB, 
  System.SysUtils, 
  System.Generics.Collections, 
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
    Fid: Integer;
//    Fclient_foto: TBlob;
  public
    { Public declarations }
    [Restrictions([TRestriction.NoUpdate, TRestriction.NotNull])]
    [Column('client_id', ftInteger)]
    [Dictionary('client_id','Mensagem de validação','','','',taCenter)]
    property client_id: Integer read Fclient_id write Fclient_id;

    [Column('client_name', ftString, 40)]
    [Dictionary('client_name','Mensagem de validação','','','',taLeftJustify)]
    property client_name: String read Fclient_name write Fclient_name;

//    [Restrictions([NoUpdate, NotNull])]
//    [Column('id', ftInteger)]
//    [Dictionary('id','Mensagem de validação','','','',taCenter)]
//    property id: Integer read Fid write Fid;

//    [Column('client_foto', ftBlob)]
//    [Dictionary('client_foto','Mensagem de validação')]
//    property client_foto: TBlob read Fclient_foto write Fclient_foto;
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(Tclient);

end.
