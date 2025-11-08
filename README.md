<h1>Ruína de Slimes</h1>
<h4>Documentação Preliminar</h4>
<b><p>Modelo de Domínio Preliminar [Armazenamento de Dados para Progressão]</p></b>
<img width="978" height="582" alt="image" src="https://github.com/user-attachments/assets/75e489f9-3362-4b26-b2c6-e60beae8cdba" />
Modelo supercial do relacionamento de tabelas necessárias para amazenamento dos dados de progressão.
Nesse modelo definido o <code>Jogador</code> tem a possibilidade qual personagem irá utilizar a partir de um catálogo pré-definido. Cada Personagem possui <b>diferentes quantidades de vida/velocidaed de movimento e diferentes itens iniciais</b>.
A definição do item inicial é definina na regra do caso de uso pelo código a fim de evitar conexões redundantes no banco de dados.<br>

<p><code>Scripts</code>buscam comportamentos genéricos que possam ser compartilhados entre diversos inimigos através de um gerenciador.</p>
<b>A parte de caracteristiacas individuais, comportamentos como modo de perseguição são genéricos. A separação desses scripts em uma tabela pode não ser aplicada na versão final do banco. A modelagem descrita tem como objetivo ser utilizada como base de desenvolvimento.

-------------------------------------------------------------
Funcionalidades Mínimas Requeridas :<br>
  * Atacar/Ser Atacado por Inimigos
  * Utilizar mais de um equipamento
  * Enfrentar mais de um tipo de inimigo
  * Enfrentar inimigos com comportamentos diferentes
  * Coleta de Experiência
  * Evolução de equipamentos
  * Coleta/Seleção de Itens
  * Armazenamento de progressão<br>
   -------------------------------------------------------------

<b><p>Diagrama Refêrencia e Hierarquia de Nodes</p></b>
<div styles="borer-radius:12px;"><img  width="1336" height="587" alt="image" src="https://github.com/user-attachments/assets/e304bdfe-3401-435f-8ef6-45bcf7fe7bd0" /></div>

<p>[NOME DAS FUNÇÕES ASSOCIADAS ILUSTRATIVAS] Diagrama Guia para inserção das funcionalidades basicas do jogo a ser desenvolvido. Equanto a relação <b>Mundo -> Jogador</b> não apresenta alta complexidade é necessário cuidado com a lógica referente aos gerenciadores de estado de <code>Equipamentos</code> e <code>Inimigos</code></p>
<p>Os gerenciadores em ambos os casos servirão como controladores genéricos que farão a chamada e instanciação dos objetos pelos quais são responsáveis. Assim a inclusão de novas armas e inimigos pode ser realizada com maior facilidade</p>
<p><code>Inimigos e Equipamentos</code> podem conter seus proprios scripts e comportamentos. Os controladores tem o papel de associar ambos ao Jogador/Mundo quando seus <b>gatilhos</b> forem ativados </p>
<b><p>Exemplo de Interação <code>Controlador -> Equipamento</code>:</p></b><br>
  - <b>[Equipamento]</b>-------------------> Comportamento Base (Circular, Ricochete, Linha Reta, Dano em Area); Quantidade Base de Projéteies ; Possíveis evoluções; Tempo de Recarga Base)<br>
  - <b>[Gerenciador de Equipamento]</b>-> Instanciação do Equipamento; Multiplicador de Projeiteis e Tempo de Rergarga(Baseado no Nível e Evolução); Controle de Inventário;
---------------------------------------------------------------------
<b><p>Casos de Uso Base [<code>Jogador</code> -> <code>Inimigo</code>]</p></b>

<img width="595" height="193" alt="image" src="https://github.com/user-attachments/assets/4af711a5-ac1d-43cb-8dc4-3a40f8431084" />

<img width="1082" height="262" alt="image" src="https://github.com/user-attachments/assets/1e8f988c-baa7-4ffa-8235-2cf3d4880851" />

