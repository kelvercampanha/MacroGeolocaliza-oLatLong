# MacroGeolocalizacaoLatLong

Durante a análise espacial através de dados de referência pontual (LatLong), em algum momento pode ser pertinente encontrar em qual macro-região uma determinada coordenada se encontra. 
Nesse exemplo, através de um banco de dados público de New York City (Emergency Response Incidents), e mantido pelo Office of Emergency Management (OEM), cada ponto no espaço será associado a um distrito (poderíamos ter adotado qualquer outra região que disponha de um grid poligonal. Por fim, os resultados serão apresentados por cada uma das macro-regiões.

Os dados de georreferenciamento plotados em termos de latitude e longitude nos proporciona a seguinte visualização:

![stack Overflow](https://github.com/kelvercampanha/MacroGeolocalizacaoLatLong/blob/master/PlotCoordinates.png)

Agrupando-se as localizações segundo seu distrito de ocorrência, torna-se possivel, por exemplo, direcionar políticas públicas para áreas de maior necessidade.

![stack Overflow](https://github.com/kelvercampanha/MacroGeolocalizacaoLatLong/blob/master/PlotHeatMap.png)
