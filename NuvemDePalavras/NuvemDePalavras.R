getwd()
setwd("c:/PROJETOS_GIT/Projetos_NLP/NuvemDePalavras")


# Instale os pacotes abaixo:
#install.packages("tm")
#install.package("SnowballC")
#install.packages("wordcloud")
#install.packages("RColorBrewer")

# Carregue os pacotes:
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")

# Crie um arquivo com v�rias palavras repetidas e salve no diret�rio do script.
#Neste exemplo criei um arquivo com v�rios nomes de frutas.

# Atribuindo o arquivo a um objeto chamado "arquivo"
arquivo <- "frutas.txt"

# Lendo o arquivo
texto <- readLines(arquivo)


# Criando uma cole��o de documentos com o objeto Corpus.
# Este objeto � utilizado para se trabalhar an�lise estat�stica dentro de strings e permite o tratamento de uma grande massa de texto:
docs <- Corpus(VectorSource(texto))

# Verificando todos os dados encontrados:
inspect(docs)


# Convertendo o texto para min�sculo:
docs <- tm_map(docs, content_transformer(tolower))


# Removendo n�meros:
docs <- tm_map(docs, removeNumbers)


# Juntando as palavras que aparecem com maior frequ�ncia:
docs <- tm_map(docs, stemDocument)

# Criando uma matriz:
tdm <- TermDocumentMatrix(docs)
m <- as.matrix(tdm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)



# Mostra as palavras que mais aparecem e a frequ�ncia:
head(d, 10)


# Construindo a nuvem de palavras (wordcloud):
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35,
          colors=brewer.pal(8, "Dark2"))

#words = lista de palavras
#freq = frequ�ncia de palavras
#min.freq = 1 -> frequ�ncia m�nima para que uma palavra apare�a
#max.words=200 -> m�ximo de palavras que devem aparecer
#random.order=FALSE -> as palavras com maior frequ�ncia aparecem no centro da nuvem e em tamanho maior
#rot.per -> grau de rota��o das palavras
#colors -> cores da menor frequ�ncia para a maior frequ�ncia

#----------------------------------------------------------

# Tabela de frequ�ncia:
findFreqTerms(tdm, lowfreq = 4)
findAssocs(tdm, terms = "freedom", corlimit = 0.3)
head(d, 10)


# Gr�fico de barras com as palavras mais frequentes:
barplot(d[1:10,]$freq, las = 2, names.arg = d[1:10,]$word,
        col ="gray", main ="Palavras Mais Frequentes",
        ylab = "Frequ�ncias de Palavras")



