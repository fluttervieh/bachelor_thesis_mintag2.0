class QuoteDTO{

  String? quoteId;
  String quote;
  String author;

  QuoteDTO(this.quote, this.author);

  void setId(String quoteId){
    this.quoteId = quoteId;
  }

  Map<String, dynamic> toJson(){
    return {
      'quote' : quote,
      'author': author,
    };
  }
}