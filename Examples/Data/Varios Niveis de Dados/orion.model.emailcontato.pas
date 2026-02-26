unit orion.model.emailcontato;

interface

uses
  Data.DB, 
  System.Classes, 
  System.SysUtils, 
  System.Generics.Collections, 

  /// orm 
  ormbr.types.blob,
  ormbr.types.lazy, 
  dbcbr.types.mapping,
  ormbr.types.nullable,
  dbcbr.mapping.classes,
  dbcbr.mapping.register,
  dbcbr.mapping.attributes;

type
  [Entity]
  [Table('emailcontato', '')]
  [PrimaryKey('id', TAutoIncType.NotInc,
                    TGeneratorType.NoneInc,
                    TSortingOrder.NoSort,
                    False, 'Chave primária')]
  Temailcontato = class
  private
    { Private declarations } 
    Fid: Nullable<Integer>;
    Ftipo: Nullable<String>;
    Fendereco: Nullable<String>;
    Fcontato_id: Nullable<Integer>;

  public 
    { Public declarations } 
    constructor Create;
    destructor Destroy; override;
    [Column('id', ftInteger)]
    [Dictionary('id', 'Mensagem de validação', '', '', '', taCenter)]
    property id: Nullable<Integer> read Fid write Fid;

    [Column('tipo', ftString, 1)]
    [Dictionary('tipo', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property tipo: Nullable<String> read Ftipo write Ftipo;

    [Column('endereco', ftString, 150)]
    [Dictionary('endereco', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property endereco: Nullable<String> read Fendereco write Fendereco;

    [Column('contato_id', ftInteger)]
    [ForeignKey('fk_emailcontato_contato', 'contato_id', 'contato', 'id', TRuleAction.Cascade, TRuleAction.Cascade)]
    [Dictionary('contato_id', 'Mensagem de validação', '', '', '', taCenter)]
    property contato_id: Nullable<Integer> read Fcontato_id write Fcontato_id;
  end;

implementation

constructor Temailcontato.Create;
begin

end;

destructor Temailcontato.Destroy;
begin

  inherited;
end;

initialization

  TRegisterClass.RegisterEntity(Temailcontato)

end.
