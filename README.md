# SporthecaTest
Teste desenvolvido para avaliação técnica

O objetivo deste teste é criar um app que obtenha o mesmo resultado da imagem abaixo:
![testeConsumoApi](https://user-images.githubusercontent.com/12645172/203700746-7b6cea13-8d07-4f4c-9153-22d10db25281.jpg)

Fazendo o consumo do arquivo json disponível em <a href="url">http://sportsmatch.com.br/teste/teste.json</a>


<pre>
    <code>
 {
  "Status": 200,
  "Object": [
    {
      "Player": {
        "img": "http://sportsmatch.com.br/teste/img.jpg",
        "name": "Usuário de Teste",
        "percentual": 59.193163771924,
        "pos": "Atacante",
        "country": "Alemanha",
        "Barras": {
          "Copas_do_Mundo_Vencidas": {
            "max": 3,
            "pla": 1,
            "pos": 18
          },
          "Copas_do_Mundo_Disputadas": {
            "max": 5,
            "pla": 4,
            "pos": 2
          }
        }
      }
    }
  ]
}</code>
</pre>

<p>Regras:</p>
<div>• A imagem de fundo, assim como a combinação de cores, podem ser qualquer uma a sua escolha.

• Os valores devem ser preenchidos dinamicamente, de acordo com o conteúdo do arquivo json.

• Os preenchimentos das barras tambem devem ser dinâmicos.
O valor máximo da barra é definido através do parâmetro "max", e o valor de preenchimento (proporcional) deve ser obtido através do parâmetro "pla".</div>
