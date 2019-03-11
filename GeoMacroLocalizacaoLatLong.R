#Limpa a memoria do R
rm(list=ls(all=TRUE))

#Carregando os pacotes necessarios
if(!require(maptools)){install.packages("maptools"); require(maptools)}
if(!require(PBSmapping)){install.packages("PBSmapping"); require(PBSmapping)}
if(!require(devtools)){install.packages("devtools"); require(devtools)}
if(!require(rgdal)){install.packages("rgdal"); require(rgdal)}
if(!require(dplyr)){install.packages("dplyr"); require(dplyr)}
if(!require(geosphere)){install.packages("geosphere"); require(geosphere)}
if(!require(raster)){install.packages("raster"); require(raster)}
if(!require(GISTools)){install.packages("GISTools"); require(GISTools)}
if(!require(geojsonio)){install.packages("geojsonio"); require(geojsonio)}


#Leitura do arquivo Shape file de Distritos de NY
NY <- readOGR("C:/Users/User/Desktop/Geo/nybb_16d/nybb.shp")
#Corrigindo a projecao
NY2 <- spTransform(NY, CRS("+proj=longlat +datum=WGS84"))
#Data frame de covariaveis que compoe o shape
TNY2=as.data.frame(NY2)

#Plotando o mapa
#dev.new() #Abre uma nova nova janela grafica
plot(NY2,main=paste("New York City:","Nº de chamadas para emergência","2012 à 2016", sep="\n"),cex.lab=0.5,cex.main=0.8)

#Lendo os dados com as coordenadas dos eventos
dados=read.table("C:/Users/KLC/Desktop/Projeto Geo/ChamadosEmergenciaNY.txt",header=T,sep=";")
#Filtra missings nas coordenadas geograficas
dadosLoc=subset(dados[,2:1],!is.na(Latitude));names(dadosLoc)=c("long","lat")
#convertendo os dados de lat long para o formato geopoints
coordinates(dadosLoc) <- ~long+lat

#Plotando as coordenadas sobre o mapa
points(dadosLoc, col = "red", cex = 0.2,pch=19)
#Escrevendo os nomes dos distritos no mapa
text(coordinates(NY2), labels=NY2$BoroName, cex=1,font=2)

#Extraindo o distrito em que se encontra a coordenada
dadosLoc@proj4string <- NY2@proj4string#setando o mesmo formato de projecao nos dados geolocalizacao
points_in_shape <- over(dadosLoc, NY2)#procura o ponto dentro dos distritos
Distrito_do_ponto=cbind(as.data.frame(dadosLoc), points_in_shape["BoroName"])#consolida coordenada e distrito

#Sumariza a informacao dos distritos em termos da frequencia de eventos
DadosFreq=Distrito_do_ponto %>% 
  group_by(BoroName) %>% 
  summarise(N_Chamadas=n()) %>% 
  as.data.frame()

#Junta a informacao calculada no passo anterior ao data frame original do shape
TNY2=TNY2 %>% 
  left_join(DadosFreq,by=c("BoroName"="BoroName")) %>% 
  as.data.frame()

#Inclui a informacao do numero de chamados a lista de objetos do shape
NY2$N_Chamadas=TNY2$N_Chamadas#Devido a classe dos objetos, isso nao pode ser feito no passo anterior

#Parametros para o Plot do heatmap
n=nrow(TNY2)#Numero de distritos
ncat=3#Numero de categorias na escala de cores
q=quantile(NY2$N_Chamadas,seq(0,1,length=ncat))#definindo limites das categorias de cores pelo percentil das ocorrencias
id=findInterval(NY2$N_Chamadas,q)#Associa o numero de ocorrencias ao seu respectivo distrito
colfunc <- colorRampPalette(c("white", "coral1"))#Funcao para a escala das cores

#Heatmap dos distrito
#dev.new()
par(mar = c(3.5,0.5,2.5,0.5))#ajustando margens da janela grafica
layout(matrix(1:2,ncol=2), width = c(0.85,0.15),height = c(1,1))#dividindo o espaço entre mapa e legenda
#Plot
plot(NY2,col=colfunc(3)[id],main=paste("New York City:","Nº de chamadas para emergência","2012 à 2016", sep="\n"),cex.lab=0.5,cex.main=0.8)
text(coordinates(NY2), labels=NY2$BoroName, cex=0.8,font=2)
#Criacao da legenda
legend_image <- as.raster(matrix(colfunc(3), ncol=1))
plot(c(0,8),c(0,2),type = 'n', axes = F,xlab = '', ylab = '', main = '')
text(x=3.5, y = seq(1,0,l=5), labels = seq(0,1000,l=5),cex=0.8)
rasterImage(legend_image, 0, 0, 1,1)
