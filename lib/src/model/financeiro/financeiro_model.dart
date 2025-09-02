class FinanceiroModel {
  int? id;
  String? descricao;
  String? valor;
  String? data;
  int? tipo;
  int? quitada;

  FinanceiroModel({
    this.descricao,
    this.id,
    this.quitada,
    this.data,
    this.tipo,
    this.valor,
  });
}
