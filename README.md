# MacroGeolocalizacaoLatLong

Durante a analise espacial atraves de dados de referencia pontual (LatLong), em algum momento pode ser pertinente encontrar em qual macro-regiao uma determinada coordenada se encontra. 
Nesse exemplo, atraves de um banco de dados publico de New York City (Emergency Response Incidents), e mantido pelo Office of Emergency Management (OEM), cada ponto no espaco sera associado a um distrito (poderiamos ter adotado qualquer outra região que disponha de um grid poligonal. Por fim, os resultados serao apresentados por cada uma das macro-regioes.

Os dados de georreferenciamento plotados em termos de latitude e longitude nos proporciona a seguinte visualizacaoo:

![stack Overflow](https://github.com/kelvercampanha/MacroGeolocalizacaoLatLong/blob/master/PlotCoordinates.png)

Agrupando-se as localizacoes segundo seu distrito de ocorrência, torna-se possivel, por exemplo, direcionar politicas publicas para areas de maior necessidade.

![stack Overflow](https://github.com/kelvercampanha/MacroGeolocalizacaoLatLong/blob/master/PlotHeatMap.png)
