import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';

class CommunityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFFD9D9D9),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Seção de botão de voltar
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF4A4A4A),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Saudação ao usuário
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontFamily: 'Oswald',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(text: 'Olá, '),
                  TextSpan(text: 'seja bem-vindo a comunidade'),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Campo de busca e botões de ação
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFB9C0C9),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'pesquisa',
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.add, color: Color(0xFFF65600)),
                  onPressed: () {
                    // Ação para criar nova postagem
                  },
                ),
                IconButton(
                  icon: Icon(Icons.notifications, color: Color(0xFFF65600)),
                  onPressed: () {
                    // Ação para notificações
                  },
                ),
              ],
            ),
            SizedBox(height: 16),

            // Lista de Postagens
            Expanded(
              child: ListView(
                children: [
                  _buildCommunityPost(
                    title: '10 dicas para quem está começando a cultivar plantas ou alimentos',
                    content: '''Começar um jardim ou uma horta pode parecer um desafio, principalmente para quem nunca teve experiência em plantio. Mas, cultivar plantas ou alimentos pode ser muito mais simples do que parece, se você seguir algumas dicas de quem já tem experiência.
1. Plante coisas da estação
Antes de iniciar o plantio, atente às condições da estação e veja quais são as plantas ou alimentos mais apropriados para esta época. Um cultivo bem-sucedido envolve conhecer as sementes e entender o que elas precisam para se desenvolver adequadamente. Lembre-se que cada região tem suas particularidades, então gaste um tempo pesquisando o que melhor se adapta à sua área e quais períodos do ano são os mais indicados para o plantio.
2. Use substratos de qualidade
Antes de escolher qual substrato você vai comprar, analise quais são os nutrientes que ele possui. Não opte apenas pelo mais barato. As plantas precisam de um solo nutritivo para se desenvolverem, principalmente quando são cultivadas em vasos, caixas ou em qualquer outro recipiente.
3. Pesquise qual deve ser o manuseio adequado para o seu plantio
Quando falamos em cultivar alimentos, cada um tem suas particularidades. É muito importante conhece-las, para garantir que elas sejam produtivas sempre. Portanto, quando escolher o que plantar, veja também quais serão os cuidados no futuro. Por exemplo: cenoura e feijão são sensíveis a perturbações nas raízes, portanto, não devem ser plantadas em vasos e depois transplantadas para outro solo. Já o tomate pode ser cultivado em vasos e depois transportado para espaços maiores.
4. Saiba do que a sua planta gosta
Algumas plantas gostam de passar longos períodos no sol, enquanto outras se desenvolvem melhor à sombra. Os tomates vão muito bem com o sol, mas o alface, agrião, espinafre e muitos outros precisam de uma sombrinha.
5. Forneça a quantidade certa de água
Assim como o sol, a quantidade de água é determinante para garantir o desenvolvimento das plantas. A maior parte delas não gostam de solo seco, mas nem todas gostam de muita água. A chave para o sucesso é manter uma rela regular. O simples toque na terra já dá para perceber se ela está seca ou úmida. O ideal é mantê-la sempre úmida, mas, lembre-se: pode ser que a sua espécie goste mais de água, por isso, sempre pesquise as condições ideais antes de qualquer decisão.
6. Comece com plantas fáceis de lidar
As ervas são ideais para quem está começando a plantar e ainda não tem experiência em lidar com a terra. Elas se desenvolvem com facilidade, são extremamente úteis e vão te ajudar a ganhar confiança para investir em alimentos que precisam de cuidados mais específicos. Algumas sugestões são: alecrim, manjericão, orégano e cheiro-verde.
7. Não desanime com os erros
Cultivar alimentos também tem momentos complicados. Nem sempre, mesmo com todos os esforços, as coisas não sairão como planejado. Até mesmo os agricultores experientes são surpreendidos na hora da colheita. Plantar também é um jogo de erros e acertos, até que tudo se acerte. Portanto, não desanime diante de uma experiência ruim. Sempre existe a possibilidade de aprender algo e tentar novamente, até com outras coisas.
8. Nem tudo é culpa sua
Não ache que quando uma planta morre você é o culpado. Além de fazer parte do ciclo, existem inúmeros fatores que contribuem para o bom desenvolvimento ou morte de uma planta. Nem tudo está sob seu próprio controle.
9. Troque experiências e converse com outras pessoas
Quem gosta de plantar, normalmente gosta de compartilhar experiências e histórias sobre isso. Aproveite essas oportunidades para aprender e entender melhor como funciona o universo das plantas. Não tenha medo de perguntar. Uma boa dica para quem usa o Facebook é participar do grupo dos Hortelões Urbanos. São mais de 55 mil pessoas de todo o Brasil compartilhando suas experiências e conhecimentos. Clique aqui para ver.
10. Aprenda com os seus erros e não tenha medo de falhar
O melhor jeito de aprender é fazendo. Não tenha medo de tentar e nem de pedir ajuda quando necessário. Ao longo do tempo você perceberá que o caminho do conhecimento é cheio de testes e erros, são eles que nos ajudam a aprender e entender melhor como as coisas funcionam. Isso vale para a jardinagem e para a vida.
''',
                    author: 'João',
                    likes: 12,
                    comments: 5,
                    onShare: () {
                      // Ação de compartilhamento
                    },
                  ),
                  _buildCommunityPost(
                    title: 'Do Solo à Colheita: Técnicas Essenciais de Cultivo',
                    content:'''O cultivo é uma jornada que começa com a preparação do solo e só termina na colheita, passando por uma série de etapas importantes para garantir que as plantas cresçam saudáveis e fortes. Neste artigo, vamos explorar algumas das principais técnicas de cultivo que qualquer entusiasta ou pequeno agricultor deve conhecer para obter colheitas produtivas e de alta qualidade.
1. Preparação do Solo
A base de qualquer cultivo bem-sucedido está no solo. Antes de plantar, é essencial garantir que ele tenha os nutrientes necessários para sustentar as plantas. O primeiro passo é testar o pH do solo e corrigir se necessário – a maioria das plantas prefere um pH ligeiramente ácido a neutro (entre 6 e 7). Além disso, enriquecer o solo com compostos orgânicos, como esterco ou compostagem, ajuda a melhorar a fertilidade e a estrutura, facilitando a retenção de água e nutrientes.
2. Escolha das Sementes e Mudas
A escolha de sementes ou mudas de qualidade é um diferencial. Dê preferência a variedades adequadas para o clima e as condições de cultivo da sua região. Selecione também espécies que atendam às suas expectativas de colheita em termos de sabor, resistência a pragas e tempo de crescimento.
3. Irrigação Eficiente
Cada fase de crescimento das plantas demanda uma quantidade específica de água. Nos primeiros estágios, a rega regular é essencial para estimular o enraizamento. Conforme as plantas crescem, ajuste a frequência e quantidade de água para evitar o estresse hídrico. A irrigação por gotejamento é uma excelente técnica, pois permite um uso eficiente da água e garante que as raízes recebam a umidade de que precisam sem encharcar o solo.
4. Controle de Pragas e Doenças
Manter as plantas saudáveis envolve protegê-las de pragas e doenças. Uma abordagem sustentável é o controle integrado, que combina métodos biológicos, como o uso de predadores naturais, com práticas culturais, como a rotação de culturas e o plantio de espécies repelentes ao redor das plantas principais. Evite o uso excessivo de pesticidas, que podem prejudicar o solo e afetar a qualidade da colheita.
5. Adubação e Nutrição
As plantas precisam de nutrientes específicos em cada etapa do seu desenvolvimento. Durante o crescimento vegetativo, priorize adubos ricos em nitrogênio. Na fase de floração e frutificação, foque em potássio e fósforo, que incentivam o desenvolvimento dos frutos. O uso de adubos orgânicos é recomendado para manter a saúde do solo a longo prazo e garantir alimentos livres de resíduos químicos.
6. Colheita no Ponto Certo
A colheita é o momento de maior recompensa no cultivo. Saber o ponto certo para colher é fundamental para garantir a qualidade. Colha os vegetais no estágio ideal de maturação, observando o tamanho, a cor e o aroma característicos. Para frutas, o aroma e a textura são ótimos indicadores de maturação.
Conclusão
Desde a preparação do solo até a colheita, cada etapa do cultivo demanda atenção e cuidado. Com técnicas adequadas e práticas sustentáveis, é possível não apenas melhorar a produtividade, mas também cultivar alimentos mais saudáveis e saborosos. Quer você seja um entusiasta da jardinagem ou um pequeno agricultor, lembre-se de que o sucesso na colheita começa com um solo bem cuidado e termina com a paciência e o conhecimento aplicados ao longo do processo.
Essas técnicas podem fazer uma grande diferença no seu cultivo, levando-o do solo até a colheita com resultados impressionantes.
''',
                    author: 'Maria',
                    likes: 8,
                    comments: 2,
                    onShare: () {
                      // Ação de compartilhamento
                    },
                  ),
                  _buildCommunityPost(
                    title: 'Hidroponia para Todos: Um Guia Prático',
                    content:'''A hidroponia, uma técnica de cultivo sem solo, tem conquistado adeptos no mundo inteiro por sua praticidade e eficiência. Ideal para quem deseja cultivar em espaços pequenos, como varandas e quintais, ou para quem busca um cultivo mais sustentável e controlado. Neste guia prático, vamos explorar os principais conceitos e passos para você começar sua própria horta hidropônica em casa.
1. O que é Hidroponia?
Na hidroponia, as plantas crescem em uma solução rica em nutrientes, substituindo o solo por um sistema que fornece diretamente tudo o que elas precisam. Essa técnica permite um controle mais preciso do ambiente de cultivo, ajudando a reduzir o desperdício de água e nutrientes e oferecendo uma alternativa ao cultivo tradicional, especialmente em áreas urbanas ou com solo de baixa qualidade.
2. Vantagens da Hidroponia
A hidroponia traz diversas vantagens. Como não depende do solo, reduz a necessidade de pesticidas e evita o problema de pragas e doenças comuns no cultivo terrestre. Além disso, é uma técnica que utiliza até 90% menos água do que a agricultura tradicional, pois a água circula no sistema e é reutilizada, tornando o cultivo mais sustentável.
3. Escolha do Sistema Hidropônico
Existem diferentes tipos de sistemas hidropônicos, e escolher o ideal depende do espaço disponível e do tipo de planta que deseja cultivar. Os sistemas mais comuns são:
NFT (Nutrient Film Technique): As raízes crescem em um canal onde circula uma fina camada de solução nutritiva.
DWC (Deep Water Culture): As raízes ficam imersas em uma solução rica em nutrientes.
Sistema de Gotejamento: A solução é aplicada diretamente nas raízes através de gotejadores, ideal para hortas pequenas.
Cada sistema possui suas próprias características e é mais indicado para determinados tipos de planta, então vale a pena estudar qual atende melhor às suas necessidades.
4. Preparação da Solução Nutritiva
A solução nutritiva é o que alimenta as plantas e substitui o papel do solo. Ela deve conter todos os nutrientes essenciais, como nitrogênio, fósforo, potássio, cálcio e magnésio, ajustados para as necessidades de cada tipo de planta. Você pode comprar soluções prontas ou prepará-las com base nas especificações das plantas que quer cultivar. Verifique o pH regularmente (mantendo entre 5,5 e 6,5) para garantir que as plantas absorvam bem os nutrientes.
5. Escolha das Plantas
Muitas plantas se adaptam bem à hidroponia, mas algumas são mais fáceis para iniciantes, como alface, rúcula, espinafre e manjericão. Essas plantas têm raízes pequenas e crescem rapidamente, tornando o processo mais simples para quem está começando. À medida que você se familiariza com a técnica, pode experimentar cultivar plantas frutíferas, como morangos e tomates.
6. Montagem e Manutenção do Sistema
Montar o sistema hidropônico requer alguns itens básicos, como tubos, reservatório, bomba de água e recipientes para as plantas. Após a montagem, é importante monitorar regularmente a solução nutritiva, garantindo que o nível e a concentração de nutrientes estejam corretos. A luz também é fundamental, então, se o sistema estiver em um ambiente interno, considere o uso de lâmpadas de crescimento.
7. Colheita
Um dos maiores prazeres da hidroponia é a colheita. Como você está cultivando em um ambiente controlado, as plantas costumam crescer mais rápido do que no solo. Colha as folhas e frutos no ponto ideal de maturação, e aproveite o sabor fresco que só o cultivo em casa pode proporcionar.
Conclusão
A hidroponia é uma técnica acessível que permite cultivar plantas de forma sustentável e eficiente, mesmo em espaços pequenos. Com um pouco de dedicação e o sistema certo, qualquer pessoa pode ter uma horta hidropônica em casa e colher alimentos frescos o ano todo. Experimente essa técnica e descubra como a hidroponia pode transformar sua experiência de cultivo.
''',
                    author: 'Luciano',
                    likes: 20,
                    comments: 7,
                    onShare: () {
                      // Ação de compartilhamento
                    },
                  ),
                  _buildCommunityPost(
                    title: 'Companheirismo de Plantas: A Arte de Cultivar em Harmonia',
                    content: '''O companheirismo de plantas, ou plantio consorciado, é uma técnica que utiliza a relação natural entre espécies para promover um crescimento mais saudável e sustentável. Quando cultivadas juntas, algumas plantas se ajudam, seja afastando pragas, enriquecendo o solo ou fornecendo sombra e suporte umas para as outras. Neste artigo, vamos explorar como o companheirismo de plantas pode transformar sua horta ou jardim, otimizando o espaço e trazendo benefícios naturais para as plantas.
1. O Que é Companheirismo de Plantas?
O companheirismo de plantas é uma prática de cultivar diferentes espécies lado a lado para que se beneficiem mutuamente. Por exemplo, algumas plantas exalam aromas que afastam insetos, enquanto outras podem melhorar a fertilidade do solo ao liberar nutrientes essenciais. Esse tipo de plantio ajuda a manter o ecossistema do jardim saudável e balanceado, reduzindo a necessidade de produtos químicos e intervenções artificiais.
2. Benefícios do Companheirismo
Cultivar plantas companheiras traz diversas vantagens:
Controle de Pragas Natural: Certas plantas, como o manjericão e a calêndula, liberam substâncias que repelem insetos prejudiciais, protegendo as plantas vizinhas.
Melhora do Solo: Leguminosas como feijões e ervilhas fixam nitrogênio no solo, beneficiando plantas que necessitam desse nutriente.
Aproveitamento do Espaço: Plantar espécies de diferentes alturas e sistemas de raízes permite um uso mais eficiente do solo, com menos competição entre as plantas.
3. Exemplos Clássicos de Companheirismo
Algumas combinações de plantas são bem conhecidas por seus benefícios. Aqui estão algumas das mais populares:
Milho, Feijão e Abóbora: Conhecido como as “Três Irmãs”, esse trio clássico é cultivado tradicionalmente por várias culturas indígenas. O milho fornece suporte para o feijão, que, por sua vez, enriquece o solo, enquanto a abóbora cobre o solo, reduzindo a erosão e inibindo ervas daninhas.
Tomate e Manjericão: Além de serem ótimos na cozinha, tomate e manjericão são uma excelente dupla no jardim. O manjericão ajuda a repelir insetos e melhora o sabor dos tomates.
Cenoura e Cebolinha: A cebolinha ajuda a afastar pragas que atacam as cenouras, como a mosca-da-cenoura, além de ocupar pouco espaço e crescer bem ao lado das raízes das cenouras.
4. Evite Plantas Incompatíveis
Assim como existem plantas que se ajudam, outras competem entre si ou podem até prejudicar o crescimento umas das outras. Por exemplo, evite plantar cebolas perto de ervilhas, pois elas podem competir pelos mesmos nutrientes. Estude as combinações antes de plantar para garantir que as espécies escolhidas realmente se complementem.
5. Planejamento do Plantio
Para aproveitar ao máximo o companheirismo de plantas, faça um planejamento do seu espaço de cultivo. Considere o tipo de solo, a luz, o espaço necessário para cada planta e o ciclo de crescimento. Um bom planejamento permite que você organize seu jardim para que as plantas tenham o ambiente ideal e cresçam de forma saudável.
Conclusão
O companheirismo de plantas é uma prática simples, mas que faz toda a diferença na saúde e produtividade do seu jardim. Combinando as plantas certas, você cria um ambiente harmonioso, reduz o uso de produtos químicos e ainda obtém uma colheita mais abundante. Experimente aplicar o companheirismo de plantas no seu cultivo e veja como a natureza, quando bem entendida, tem tudo para trabalhar a seu favor.
''',
                    author: 'Pedro J.',
                    likes: 15,
                    comments: 3,
                    onShare: () {
                      // Ação de compartilhamento
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Barra de navegação inferior personalizada
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color(0xFF0F6D5F),
              width: 4,
            ),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Color(0xFFECECEC),
          selectedItemColor: Color(0xFF225149),
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 24),
              label: 'Início',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.analytics, size: 24),
              label: 'Métricas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 24),
              label: 'Perfil',
            ),
          ],
          currentIndex: 0,
          onTap: (index) {
            if (index == 0) {
              Navigator.pushNamed(context, '/home');
            } else if (index == 1) {
              Navigator.pushNamed(context, '/report');
            } else if (index == 2) {
              Navigator.pushNamed(context, '/profile');
            }
          },
        ),
      ),
    );
  }

  // Método auxiliar para construir postagens da comunidade
  Widget _buildCommunityPost({
    required String title,
    required String content,
    required String author,
    required int likes,
    required int comments,
    required VoidCallback onShare,
  }) {
    return Card(
      color: Color(0xFF1E1E1E), // Alterado para cor conforme solicitado
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Oswald',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Por: $author',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(
                fontFamily: 'Oswald',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.favorite, color: Colors.red, size: 20),
                    SizedBox(width: 4),
                    Text('$likes', style: TextStyle(color: Colors.white70)),
                    SizedBox(width: 16),
                    Icon(Icons.comment, color: Colors.black, size: 20),
                    SizedBox(width: 4),
                    Text('$comments', style: TextStyle(color: Colors.white70)),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.share, color: Colors.black),
                  onPressed: onShare,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
