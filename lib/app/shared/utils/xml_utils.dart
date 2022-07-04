class XmlUtils {
  static String correiosRequestFromTrackingCode(String code) {
    return '''
      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
      xmlns:res="http://resource.webservice.correios.com.br/"> 
        <soapenv:Header/>
          <soapenv:Body>  
            <res:buscaEventosLista> 
              <usuario>ECT</usuario> 
              <senha>SRO</senha>  
              <tipo>L</tipo>  
              <resultado>T</resultado>  
              <lingua>102</lingua> 
              <objetos>$code</objetos> 
            </res:buscaEventosLista>  
          </soapenv:Body> 
        </soapenv:Envelope>
    ''';
  }
}
