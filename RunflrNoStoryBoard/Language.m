//
//  Language.m
//  rundlr
//
//  Created by Helder Pereira on 8/30/13.
//  Copyright (c) 2013 reality6. All rights reserved.
//

#import "Language.h"

static NSDictionary *langPT = nil;
static NSDictionary *langEN = nil;
static NSDictionary *langES = nil;
static NSDictionary *langFR = nil;

@implementation Language

+ (void)createLanguage
{
    langPT = @{
               // RATE
               @"RateText": @"A sua pontuação",
               @"RateLimpar": @"Limpar",
               @"RateVotar": @"Votar",
               
               
               //FACE
               @"FaceDefault": @"Estou a usar a #Rundlr para descobrir restaurantes maravilhosos. Podes fazer o download gratuito da Rundlr app para iOS em: http://itunes.apple.com/us/rundlr",
               @"FaceDefaultRest": @"%@\n%@\nAcabei de descobrir este maravilhoso restaurante na #Rundlr. Descobre-o tu também.",
               @"FaceText": @"Estou a usar a Rundlr para descobrir restaurantes maravilhosos. Podes fazer o download gratuito da Rundlr app para iOS em: http://itunes.apple.com/us/rundlr",
               
               // MAIN VIEW
               @"MainExplore": @"EXPLORE",
               @"MainFrase1": @"Descubra restaurantes",
               @"MainFrase2": @"por localização",
               @"MainPesquise": @"PESQUISE",
               @"MainFrasePesquise": @"Encontre algo mais específico, pesquise como pensa",
               @"MainTop10": @"TOP 10",
               @"MainComent": @"COMENT.",
               @"MainMenu": @"MENU DO DIA",
               @"MainNoticias": @"NOTÍCIAS",
               @"MainVouchers": @"VOUCHERS",
               @"MainLogin": @"LOGIN",
               @"MainNumC": @"Comentários",
               @"MainNumF": @"Seguidores",
               
               
               // RESTAURANTES
               @"RestInfo": @"INFO",
               @"RestLocal": @"LOCALIZ.",
               @"RestMenu": @"MENU",
               @"RestComent": @"COMENT.",
               @"RestVotes": @"",
               @"RestCall": @"Ligar",
              
               @"RestFollowNews": @"Seguir notícias",
               @"RestFollowMenu": @"Seguir menu diário",
               @"RestFollowVouchers": @"Seguir vouchers",
               @"RestFollowComments": @"Seguir comentários",
               
               @"RestShareSMS": @"Partilhar por sms",
               @"RestShareEmail": @"Partilhar por email",
               @"RestShareFace": @"Partilhar no Facebook",
               
               @"RestShareTwitter": @"Partilhar no Twitter",
               @"RestNaoaderente": @"Este restaurante ainda não disponibiliza esta informação.\nClica aqui e mostra o teu interesse.",
               
               @"RestAgite": @"Agita para obter outra sugestão aleatória.\nRepite se desejar...",
               @"RestMarcar": @"Marcar %d?",
               
               @"RestShareSMSText": @"Acabei de descobrir o %@ na Rundlr.",
               @"RestShareEmailText": @"Acabei de descobrir o %@ na Rundlr.",
               @"RestShareTweetText": @"Acabei de descobrir o %@ na #Rundlr.",
               
               @"RatingSelectValue": @"Por favor seleccione um valor",
               
               @"RestNotify": @"Os menus do dia de hoje já estão disponíveis para consulta.",
               
               
               // RESTAURANTES INFO
               @"InfoRestImages": @"Galeria de Imagens",
               @"InfoRestChef": @"Chef",
               @"InfoRestDesc": @"Sobre nós",
               @"InfoRestMorada": @"Morada",
               @"InfoRestCozinhas": @"Cozinha",
               @"InfoRestPreco": @"Preço médio por pessoa",
               @"InfoRestHora": @"Horário",
               @"InfoRestPaga": @"Pagamento",
               @"InfoRestOutros": @"Opções adicionais",
               @"InfoRestInfo":  @"INFORMAÇÃO",
               
               
               // RESTAURANTES LOCAL
               @"LocalRestDir":  @"Obter Direcções",
               
               
               // RESTAURANTES ESCOLHAS
               @"ChoicesRestBest": @"MELHORES ESCOLHAS",
               @"ChoicesRestMenu": @"MENU DO DIA",
               
               
               //RESTAURANTES COMENTARIO               
               @"ComRestComente": @"Comentar",               
               
               
               // RESTAURANTES UPLOAD COMENTARIO
               @"UpComRestComText": @"Comente o Restaurante",
               @"UpComRestSend": @"Comentar",
               
               
               // SETTINGS CIDADES
               @"SettingsCities": @"Cidades",
               @"SettingsSearch": @"Pesquise",
               
               
               // SETTINGS GERAIS
               @"SettingsDef": @"DEFINIÇÕES",
               @"SettingsShare": @"PARTILHAR",
               @"SettingsRundlr": @"RUNDLR APP",
               
               @"SettingsLogin": @"Login",
               @"SettingsLogout": @"Logout",
               @"SettingsLang": @"Idioma",
               
               @"SettingsShareFace": @"Partilhar no Facebook",
               @"SettingsTell": @"Conte a um amigo",
               
               @"SettingsRate": @"Classificar App",
               @"SettingsContact": @"Contacte-nos",
               @"SettingsAbout": @"Sobre nós",
               @"SettingsTerms": @"Termos e condições",
               @"SettingsPrivacy": @"Política de privacidade",
               
               @"SettingsTellSubject": @"Rundlr App",
               @"SettingsTellMessage": @"Estou a usar a Rundlr para descobrir restaurantes maravilhosos. Podes fazer o download gratuito da Rundlr app para iOS em: http://itunes.apple.com/us/rundlr",
               
               @"SettingsContactSubject": @"Rundlr App",
               @"SettingsContactMessage": @"Estou a usar a Rundlr para descobrir restaurantes maravilhosos. Podes fazer o download gratuito da Rundlr app para iOS em: http://itunes.apple.com/us/rundlr",
               
               
               // EXPLORE VIEW
               @"ExploreRefresh": @"...",
               
               @"ExploreTitle": @"EXPLORE",
               @"ExploreThisLocation": @"ESTA LOCALIZAÇÃO",
               @"ExploreRefreshLabel": @"REFRESH",
               @"ExploreNear": @"PERTO DE SI",
               @"ExploreNearText": @"Veja a lista de restaurantes perto de si",
               @"ExploreRandom": @"ALEATÓRIO",
               @"ExploreRandomText": @"Seja surpreendido por uma selecção aleatória perto de si",
               @"ExploreOtherLocation": @"OUTRA LOCALIZAÇÃO",
               
               
               // SEARCH VIEW
               @"SearchHint1": @"Dica:",
               @"SearchHint2": @"Bacalhau, Grill, Esplanada, Wi-Fi\nou pelo que vier à memória...",
               @"SearchTitle": @"PESQUISE",
               @"SearchRecent": @"PESQUISAS RECENTES",
               
               
               // RESULTS VIEW
               @"ResultsOpenTime": @"Aberto (%@)",
               
               @"ResultsTitle": @"RESULTADOS",
               
               @"ResultsCozinhas": @"COZINHAS",
               @"ResultsSearch": @"Pesquisa",
               @"ResultsOk": @"OK",
               @"ResultsLimpar": @"LIMPAR",
               @"ResultsOrderBy": @"ORDENAR POR",
               @"ResultsOrderPop": @"Popularidade",
               @"ResultsOrderVote": @"Votação",
               @"ResultsCuisineType": @"Tipo de cozinha",
               @"ResultsFiltrarPor": @"FILTRAR POR",
               @"ResultsPreco": @"PREÇO POR PESSOA",
               @"ResultsOpcoesAdicionais": @"OPÇÕES ADICIONAIS",
               @"ResultsDelivery": @"DELIVERY",
               @"ResultsNight": @"NIGHT LIFE",
               @"ResultsTake": @"TAKE AWAY",
               @"ResultsPrice1": @"< 15",
               @"ResultsPrice2": @"< 30",
               @"ResultsPrice3": @"< 50",
               @"ResultsPrice4": @"> 50",
               @"ResultsFilter": @"FILTRAR",
               @"ResultsDataConfirm": @"Confirmar",
               @"ResultsDateClose": @"Fechar",
               @"ResultsNotice": @"Não conseguimos encontrar nenhum resultado. \n\nPor favor tente com outra palavra chave.",
            
               
               // USER
               @"UserInfo": @"INFO",
               @"UserNet": @"NETWORK",
               @"UserListas": @"LISTAS",
               @"UserComent": @"COMENT.",
               @"UserEditarPerfil": @"Editar Perfil",
               @"UserCredits": @"%d Créditos",
               @"UserFollow": @"Seguir",               
               
               
               // USER INFO
               @"InfoUserRecent": @"ACTIVIDADE RECENTE",
               @"InfoUserComent": @"%d comentários",
               @"InfoUserSeguidores": @"%d seguidores",
               
               
               //USER NETWORK
               @"NetUserFollowers": @"Seguido por",
               @"NetUserFollowing": @"A seguir",
               
               
               //USER LISTS
               @"ListsUserFav": @"Favoritos",
               @"ListsUserBeen": @"Estive lá",

               
               // LOGIN VIEW
               @"LoginFace": @"Login com Facebook",
               @"LoginNoticeFace": @"Não se preocupe, nunca postamos nada no Facebook sem a sua permissão.",
               
               
               //VOUCHERS VIEW
               @"VouchersSoon": @"Estamos neste momento a correr atrás das melhores ofertas.\n\nPrometemos ser breves a encontrar ofertas imperdíveis.",

               
               //ABOUT VIEW
               @"AboutTitle": @"SOBRE NÓS",

               @"AboutSH1": @"",
               @"AboutH1": @"O que é a Rundlr?",
               @"AboutT1": @"É uma plataforma online que te permite explorar um conjunto dos melhores restaurantes da cidade e descobrir aqueles que vão ao encontro dos teus desejos. De um restaurante clássico a um típico, de um restaurante de comida internacional a um vegetariano, de uma casa de pasto a uma casa de tapas, tudo se reúne na Rundlr para proporcionar momentos de prazer à mesa.",
               
               @"AboutSH2": @"",
               @"AboutH2": @"Como funciona a Rundlr?",
               @"AboutT2": @"Não interessa o que procuras, a Rundlr vai encontrá-lo para ti.\n\nCom a Rundlr, pensas, escreves e obténs resultados por preferências através da pesquisa inteligente por prato, proximidade, serviços, ofertas ou podes deixar-te surpreender por uma sugestão aleatória.\n\nA Rundlr permite criar alertas para receber os menus do dia dos restaurantes que pretendas seguir, estar a par dos eventos e novidades dos restaurantes, criar um perfil de utilizador, seguir outros utilizadores e ter informação sobre as apreciações feitas por aqueles, criar a  própria storyboard e adquirir créditos através de acções promotoras dos restaurantes, resgatando-os posteriormente através de vouchers de descontos.",
               
               @"AboutSH3": @"",
               @"AboutH3": @"Quem usa a Rundlr?",
               @"AboutT3": @"A Rundlr é utilizada por utilizadores experientes da Internet que procuram opções para fazer as suas refeições.\n\nJunta-te tu também à Rundlr. Descobre o que está a acontecer, partilha a tua opinião e inspira mais pessoas a conhecer os restaurantes que tu visitaste.",
               
               @"AboutSH4": @"",
               @"AboutH4": @"Como podes entrar em contacto connosco?",
               @"AboutT4": @"É simples. Escreve-nos através do email hello@rundlr.com",
               
               
               // TERMS VIEW
               @"TermsTitle": @"TERMOS E CONDIÇÕES",
               
               @"TermsSH1": @"",
               @"TermsH1": @"",
               @"TermsT1": @"Ao usar os serviços da Rundlr, concorda com o seguinte:\n\nO conteúdo deste site é apenas para fins informativos.\nA Rundlr está isenta de qualquer responsabilidade por qualquer informação que se tenha tornado desactualizada desde a última vez que as informações foram actualizadas.\n\nA Rundlr reserva-se o direito de fazer alterações e correcções, em qualquer parte do conteúdo deste site e a qualquer momento, sem aviso prévio.\n\nA Rundlr não garante os preços indicados nem a disponibilidade de todos os itens das melhores escolhas em nenhum restaurante.\n\nTodos os nomes dos restaurantes, itens das melhores escolhas foram cedidas por pessoas afectas ao restaurante.\n\nSalvo indicação em contrário, todas as imagens e informações contidas neste site foram autorizadas por pessoas afectas ao restaurante e são acreditadas para serem de domínio público, como material promocional, fotos de publicidade e/ou de meios de comunicação.\n\nSolicitamos o envio de um e-mail se for o proprietário dos direitos de autor de qualquer conteúdo neste site e se, no seu entender, o uso do material violar, sob qualquer forma, a lei de direitos de autor. Neste caso, por favor indique a localização exacta do conteúdo em questão.",
               
               
               // POLICY VIEW
               @"PolicyTitle": @"POLÍTICA DE PRIVACIDADE",

               @"PolicySH1": @"",
               @"PolicyH1": @"",
               @"PolicyT1": @"A Rundlr reconhece e valoriza o seu direito à privacidade e, por isso, está comprometida com a protecção da sua privacidade online. A nossa política de privacidade está claramente explicada nas linhas abaixo. Pedimos que, antes de nos fornecer qualquer informação pessoal, leia com atenção este documento. Ao usar a Rundlr, concorda com a nossa utilização das suas informações pessoais, desde que essa utilização esteja em conformidade com esta política. Se não concordar com os termos desta política, pedimos que não utilize este site.",
               
               @"PolicySH2": @"Que informações recolhemos?",
               @"PolicyH2": @"Utilizadores sem registo",
               @"PolicyT2": @"Para tirar partido das várias funcionalidades da Rundlr, sugerimos que se registe. Se preferir não se registar, poderá aproveitar as funções do site que não exigem registo.\nSe optar por não se registar, as informações obtidas paor nós serão mais limitadas. Obteremos, por exemplo, o seu endereço de IP para ajudar a diagnosticar problemas com o nosso servidor, administrar o site e rastrear estatísticas de utilização. O endereço de IP pode variar a cada visita que faça ou pode ser sempre o mesmo, dependendo do seu acesso.\n\nIndependentemente disso, é extremamente difícil identificá-lo através do seu endereço de IP e não o tentamos fazer. Se chegar ao nosso site através de algum link ou anúncio doutro site, também registamos essa informação apenas para maximizar a nossa exposição na Internet e perceber os interesses dos nossos utilizadores. Todas essas informações são registadas e usadas apenas de forma geral, ou seja, são acrescentadas à nossa base de dados para gerar relatórios gerais sobre os nossos utilizadores, mas em momento algum em relatórios sobre um utilizador em particular.\n\nEstabelecemos uma parceria com o Facebook para oferecer a personalização instantânea na Rundlr para membros do Facebook. Se configurou a personalização instantânea como “activa” nas suas configurações de privacidade do Facebook e fez login no Facebook, o site da Rundlr será personalizado para si quando o visitar, mesmo que seja a primeira vez que acede ao site da Rundlr. O Facebook fornece as informações que disponibilizou de acordo com suas configurações de privacidade do Facebook. Essas informações podem incluir o seu nome, a foto do perfil, o género, as listas de amigos e qualquer outra informação disponibilizada.",
               
               @"PolicySH3": @"",
               @"PolicyH3": @"Utilizadores com registo",
               @"PolicyT3": @"A opção de se registar permitirá adicionar conteúdo na Rundlr. Por exemplo, pode escrever os seus próprios comentários, sendo que podemos suspender toda e qualquer mensagem que contenha conteúdo ilegal ou ofensivo tal como aquele que promova o racismo ou preconceito ou qualquer outra forma de violação legal de acordo com as leis nacionais.\n\nAlém disso, podemos apagar comentários que indiquem claramente um ataque pessoal contra um estabelecimento.\n\nAo registar-se na Rundler tem a vantagem de poder personalizar a sua experiência. As vantagens do registo aumentam com o tempo e à medida que o formos conhecendo melhor e introduzindo novas funcionalidades. Faça o seu registo e aproveite todas as experiências que a Rundlr tem para lhe proporcionar!\n\nAo receber o seu registo, recolhemos as suas informações pessoais, além das informações não-pessoais descritas acima. Essas informações pessoais podem incluir dados inseridos manualmente por si nos nossos formulários, como por exemplo o seu nome, endereço de email, endereço para correspondência, número de telefone, restaurantes favoritos, nome de utilizador e palavra chave.",
               
               @"PolicySH4": @"",
               @"PolicyH4": @"Não vendemos as suas informações pessoais.", // a terceiros
               @"PolicyT4": @"Não partilhamos as suas informações com ninguém. Em algumas partes do site existem links que o redireccionam para outros sites. Se for redireccionado para esses mesmos sites, há a possibilidade de serem recolhidas informações pessoais. Esses sites não estão dentro de nosso controlo e não são cobertos por esta política de privacidade. Se se verificar que o seu uso do site é ilegal ou prejudicial para os outros utilizadores, reservamos o direito de divulgar as suas informações obtidas através do site, na medida em que seja razoavelmente necessário, na nossa opinião, para prevenir, remediar ou tomar medidas em relação a essa conduta.",
               
               @"PolicySH5": @"",
               @"PolicyH5": @"Uso",
               @"PolicyT5": @"Usaremos as suas informações apenas para os seguintes fins:\n\nPara enviarmos regularmente notícias e informações sobre a Rundlr.\nPara de tempos a tempos fazermos perguntas ou pedir feedback para fins de pesquisa.",
               
               @"PolicySH6": @"",
               @"PolicyH6": @"Links",
               @"PolicyT6": @"Os links para outros sites são fornecidos pela Rundlr de boa fé e apenas para informação. A Rundlr isenta-se de qualquer responsabilidade por materiais contidos em qualquer site vinculado a este site.",
               
               
               //CREDITS VIEW
               @"CreditsTitle": @"CRÉDITOS",
               
               @"CreditsSH1": @"",
               @"CreditsH1": @"O que são os créditos?",
               @"CreditsT1": @"Créditos são a moeda da rundlr para premiar os utilizadores registados por todas as acções que promovam a rundlr e os seus restaurantes aderentes.",
               
               @"CreditsSH2": @"",
               @"CreditsH2": @"Para que servem os créditos?",
               @"CreditsT2": @"Os créditos servem para usufruir de descontos na rede de restaurantes aderentes ao Club rundlr.",
               
               @"CreditsSH3": @"",
               @"CreditsH3": @"Quem pode usufruir dos créditos?",
               @"CreditsT3": @"Só os utilizadores registados podem usufruir dos créditos do Club rundlr.",
               
               @"CreditsSH4": @"",
               @"CreditsH4": @"Quem pode ser membro Club rundlr?",
               @"CreditsT4": @"Todos os utilizadores registados são automaticamente membros do Club rundlr.",
               
               @"CreditsSH5": @"",
               @"CreditsH5": @"Como são obtidos os créditos?",
               @"CreditsT5": @"São obtidos pelas acções que promovam a rundlr e os restaurantes aderentes.",
               
               @"CreditsSH6": @"",
               @"CreditsH6": @"Quais são as ações que acumulam créditos?",
               @"CreditsT6": @"Classificar a app na app store\nPartilhar a app no facebook\nPartilhar os restaurantes no facebook\nPartilhar os restaurantes no twitter\nComentar os restaurantes\nClassificar os restaurantes",
               
               @"CreditsSH7": @"",
               @"CreditsH7": @"Qual o valor atribuido a cada ação?",
               @"CreditsT7": @"Classificar a app na app store – 20 créditos\nPartilhar a app no facebook – 3 créditos\nPartilhar um restaurante no facebook – 3 créditos\nPartilhar um restaurante no twitter – 3 créditos\nComentar um restaurante – 3 créditos\nComentário considerado útil por outros utilizadores – 2 créditos\nClassificar um restaurante – 5 créditos\nPassar de nivel de utilizador – 10 créditos",
               
               @"CreditsSH8": @"",
               @"CreditsH8": @"Quantos créditos são necessários para resgatar um voucher?",
               @"CreditsT8": @"1000 créditos = voucher de desconto de 10€\n3000 créditos = voucher de desconto de 40€\n5000 créditos = voucher de desconto de 80€",
               
               @"CreditsSH9": @"",
               @"CreditsH9": @"Quando se pode resgastar um voucher?",
               @"CreditsT9": @"Sempre que o utilizador pretenda usufruir das ofertas e tenha créditos equivalentes ao voucher de desconto pretendido.",
               
               @"CreditsSH10": @"",
               @"CreditsH10": @"Como se resgatam os vouchers?",
               @"CreditsT10": @"Através do envio de um email para hello@rundlr.com a solicitar o resgate do voucher pretendido.",
               
               @"CreditsSH11": @"",
               @"CreditsH11": @"Como se recebe o voucher?",
               @"CreditsT11": @"O voucher é enviado por email.",
               
               @"CreditsSH12": @"",
               @"CreditsH12": @"Onde se podem usar os vouchers?",
               @"CreditsT12": @"Nos restaurantes aderentes ao programa Club rundlr.",
               
               @"CreditsSH13": @"CONDIÇÕES GERAIS",
               @"CreditsH13": @"",
               @"CreditsT13": @"Todos os membros do Club rundlr podem consultar os seus créditos no perfil de utilizador.\nOs créditos são válidos por 2 anos.\nOs créditos só estão disponíveis para  membros do Club rundlr há pelo menos 3 meses.\nOs créditos não podem ser transferidos entre membros do Club rundlr.\nOs créditos só podem ser utilizados para as ofertas e descontos descritos no programa\nOs benefícios resultantes da sua utilização podem ser usufruídos pelo membro do Club rundlr ou alguém a quem este decida presentear.\nEm caso desactivação do perfil não há reembolso dos créditos sob qualquer forma\nNão é possível trocar o valor da oferta por dinheiro.\nA Rundlr reserva-se o direito de fazer alterações e correcções ao programa sem aviso prévio.",
              
               
               // DAY MENU VIEW
               @"DayMenuTitle": @"MENU DO DIA",
               @"DayMenuNotice": @"Ainda não estás a seguir\nnenhum menu do dia.\n\nClica em menu do dia no perfil dos restaurantes que quiseres seguir. Já está!",
               
               
               // TOP 10 VIEW
               @"Top10Title": @"TOP 10",

               
               // COMMENTS VIEW
               @"CommentsTitle": @"COMENTÁRIOS",
               
               
               // COMMENTS DETAIL VIEW
               @"DetailCommentsTitle": @"COMENTÁRIO",
               
               
               // NEWS VIEW
               @"NewsTitle": @"NOTÍCIAS",
               @"NewsNotice": @"Ainda não estás a seguir as notícias de nenhum restaurante.\n\nClica em notícias no perfil dos restaurantes que quiseres seguir. Já está!",
               
               
               // GLOBAIS
               @"GlobalFechar": @"Fechar",
               @"GlobalYes": @"Sim",
               @"GlobalNo": @"Não",
               @"GlobalOk": @"OK",
               
               @"GlobalComErrorTitle": @"Erro de comunicação.",
               @"GlobalComErrorText": @"Verifique a sua ligação à internet e tente de novo.",
               
               @"GlobalLocalErrorTitle": @"Erro.",
               @"GlobalLocalErrorText": @"Ligue os serviços de localização.",
               
               @"GlobalNoSMS": @"O seu dispositivo não suporta sms.",
               
               @"GlobalNoEmail": @"O seu dispositivo não tem o e-mail configurado.",
               
               @"GlobalInterest": @"Olá Rundlr, \n\nGostava de seguir o menu do dia do %@ \nPor favor mostra-lhe o meu interesse."
               };
    

    
    // ENGLISH LANGUAGE
    
    langEN = @{
               // RATE
               @"RateText": @"Your rating",
               @"RateLimpar": @"Clean",
               @"RateVotar": @"Rate",
               
               
               //FACE
               @"FaceDefault": @"I am using #Rundlr to discover lovely restaurants. Download free Rundlr app for iOS at: http://itunes.apple.com/us/rundlr",
               @"FaceDefaultRest": @"%@\n%@\nI just discovered this lovely restaurant at #Rundlr. Run to discover it too.",
               @"FaceText": @"I am using Rundlr to discover lovely restaurants. Download free Rundlr app for iOS at: http://itunes.apple.com/us/rundlr",
               
               // MAIN VIEW
               @"MainExplore": @"EXPLORE",
               @"MainFrase1": @"Search restaurants",
               @"MainFrase2": @"by location",
               @"MainPesquise": @"SEARCH",
               @"MainFrasePesquise": @"Insert key words if you wish something specific",
               @"MainTop10": @"TOP 10",
               @"MainComent": @"REVIEWS",
               @"MainMenu": @"DAILY MENU",
               @"MainNoticias": @"NEWS",
               @"MainVouchers": @"VOUCHERS",
               @"MainLogin": @"LOGIN",
               @"MainNumC": @"Reviews",
               @"MainNumF": @"Followers",
               
               
               // RESTAURANTES
               @"RestInfo": @"INFO",
               @"RestLocal": @"LOCATION",
               @"RestMenu": @"MENU",
               @"RestComent": @"REVIEWS",
               @"RestVotes": @"",
               @"RestCall": @"Call",
               
               @"RestFollowNews": @"Follow news",
               @"RestFollowMenu": @"Follow daily menu",
               @"RestFollowVouchers": @"Follow vouchers",
               @"RestFollowComments": @"Follow reviews",
               
               @"RestShareSMS": @"Share by sms",
               @"RestShareEmail": @"Share by email",
               @"RestShareFace": @"Share on Facebook",
               
               @"RestShareTwitter": @"Share on Twitter",
               @"RestNaoaderente": @"This restaurant doesn't provide this information yet.\nClick here to show them your interest.",
               
               @"RestAgite": @"Shake to get the next random recommendation.\nAnd so on...",
               @"RestMarcar": @"Call %d?",
               
               @"RestShareSMSText": @"I just discovered %@ at Rundlr.",
               @"RestShareEmailText": @"I just discovered %@ at Rundlr.",
               @"RestShareTweetText": @"I just discovered %@ at #Rundlr.",
               
               @"RatingSelectValue": @"Please select a value.",
               
               @"RestNotify": @"Your daily menus are available for consultation",
               
               
               // RESTAURANTES INFO
               @"InfoRestImages": @"Image Gallery",
               @"InfoRestChef": @"Chef",
               @"InfoRestDesc": @"About us",
               @"InfoRestMorada": @"Address",
               @"InfoRestCozinhas": @"Cuisine",
               @"InfoRestPreco": @"Average cost per person",
               @"InfoRestHora": @"Timing",
               @"InfoRestPaga": @"Payment",
               @"InfoRestOutros": @"Additional options",
               @"InfoRestInfo":  @"INFORMATION",
               
               
               // RESTAURANTES LOCAL
               @"LocalRestDir":  @"Get directions",
               
               
               // RESTAURANTES ESCOLHAS
               @"ChoicesRestBest": @"BEST DISHES",
               @"ChoicesRestMenu": @"DAILY MENU",
               
               
               //RESTAURANTES COMENTARIO
               @"ComRestComente": @"Review",
               
               
               // RESTAURANTES UPLOAD COMENTARIO
               @"UpComRestComText": @"Review restaurant",
               @"UpComRestSend": @"Review",
               
               
               // SETTINGS CIDADES
               @"SettingsCities": @"Cities",
               @"SettingsSearch": @"Search",
               
               
               // SETTINGS GERAIS
               @"SettingsDef": @"SETTINGS",
               @"SettingsShare": @"SHARE",
               @"SettingsRundlr": @"RUNDLR APP",
               
               @"SettingsLogin": @"Login",
               @"SettingsLogout": @"Logout",
               @"SettingsLang": @"Language",
               
               @"SettingsShareFace": @"Share on Facebook",
               @"SettingsTell": @"Tell a friend",
               
               @"SettingsRate": @"Rate App",
               @"SettingsContact": @"Contact us",
               @"SettingsAbout": @"About us",
               @"SettingsTerms": @"Terms and conditions",
               @"SettingsPrivacy": @"Privacy policy",
               
               @"SettingsTellSubject": @"Rundlr App",
               @"SettingsTellMessage": @"I am using Rundlr to discover lovely restaurants. Download free Rundlr app for iOS at: http://itunes.apple.com/us/rundlr",
               
               @"SettingsContactSubject": @"Rundlr App",
               @"SettingsContactMessage": @"I am using Rundlr to discover lovely restaurants. Download free Rundlr app for iOS at: http://itunes.apple.com/us/rundlr",
               
               
               // EXPLORE VIEW
               @"ExploreRefresh": @"...",
               
               @"ExploreTitle": @"EXPLORE",
               @"ExploreThisLocation": @"YOUR LOCATION",
               @"ExploreRefreshLabel": @"REFRESH",
               @"ExploreNear": @"NEARBY",
               @"ExploreNearText": @"See a list of restaurants near you",
               @"ExploreRandom": @"RANDOM",
               @"ExploreRandomText": @"Get random recommendation near you",
               @"ExploreOtherLocation": @"OTHER LOCATION",
               
               
               // SEARCH VIEW
               @"SearchHint1": @"Hint:",
               @"SearchHint2": @"Codfish, Grill, Outdoor seating, Wi-Fi\nor what comes to you mind...",
               @"SearchTitle": @"SEARCH",
               @"SearchRecent": @"RECENT SEARCHES",
               
               
               // RESULTS VIEW
               @"ResultsOpenTime": @"Open (%@)",
               
               @"ResultsTitle": @"RESULTS",
               
               @"ResultsCozinhas": @"CUISINES",
               @"ResultsSearch": @"Search",
               @"ResultsOk": @"OK",
               @"ResultsLimpar": @"CLEAR",
               @"ResultsOrderBy": @"ORDER BY",
               @"ResultsOrderPop": @"Popularity",
               @"ResultsOrderVote": @"Rating",
               @"ResultsCuisineType": @"Cuisines",
               @"ResultsFiltrarPor": @"FILTER BY",
               @"ResultsPreco": @"PRICE PER PERSON",
               @"ResultsOpcoesAdicionais": @"ADDITIONAL OPTIONS",
               @"ResultsDelivery": @"DELIVERY",
               @"ResultsNight": @"NIGHT LIFE",
               @"ResultsTake": @"TAKE AWAY",
               @"ResultsPrice1": @"< 15",
               @"ResultsPrice2": @"< 30",
               @"ResultsPrice3": @"< 50",
               @"ResultsPrice4": @"> 50",
               @"ResultsFilter": @"FILTER",
               @"ResultsDataConfirm": @"Confirm",
               @"ResultsDateClose": @"Close",
               @"ResultsNotice": @"There are no results for your search. \n\nPlease try another key word.",
               
               
               // USER
               @"UserInfo": @"INFO",
               @"UserNet": @"NETWORK",
               @"UserListas": @"LIST",
               @"UserComent": @"REVIEWS",
               @"UserEditarPerfil": @"Edit Profile",
               @"UserCredits": @"%d Credits",
               @"UserFollow": @"Follow",               
               
               
               // USER INFO
               @"InfoUserRecent": @"RECENT ACTIVITY",
               @"InfoUserComent": @"%d reviews.",
               @"InfoUserSeguidores": @"%d followers.",
               
               
               //USER NETWORK
               @"NetUserFollowers": @"Followed by",
               @"NetUserFollowing": @"Follows",
               
               
               //USER LISTS
               @"ListsUserFav": @"Favorites",
               @"ListsUserBeen": @"Been there",
               
               
               // LOGIN VIEW
               @"LoginFace": @"Login with Facebook",
               @"LoginNoticeFace": @"Don't worry, we will never post anything to Facebook without your permission.",
               
               
               //VOUCHERS VIEW
               @"VouchersSoon": @"We are running to get the best offers.\n\nUnmissable offers are coming very soon.",
               
               
               //ABOUT VIEW
               @"AboutTitle": @"ABOUT US",
               
               @"AboutSH1": @"",
               @"AboutH1": @"What is Rundlr?",
               @"AboutT1": @"It is an online platform that allows you to explore the best restaurants in town and find those that meet your desires. A classic restaurant, a typical one, a restaurant of international food or a vegetarian restaurant. Everything comes together in Rundlr to provide moments of pleasure.",
               
               @"AboutSH2": @"",
               @"AboutH2": @"How does Rundlr work?",
               @"AboutT2": @"No matter what your demands are, Rundlr will find it for you.\n\nWith Rundlr, you think, you write and you obtain results by preference, by intelligent search, by dish, proximity, services, offers, or you can let yourself be surprised by a random suggestion.\n\nAt Rundlr you can create alerts to receive the daily menus of restaurants that you want to follow, keep abreast of restaurant's events, creating a user profile, follow other users and have information on the assessments made by those, create your own storyboard and acquire credits through actions promoting the restaurants, rescuing them later through discount vouchers.",
               
               @"AboutSH3": @"",
               @"AboutH3": @"Who Uses Rundlr?",
               @"AboutT3": @"Rundlr is used by experienced users of the Internet looking for dining options.\nJoin Rundlr too. Find out what's happening, share your opinion and inspire more people to know the restaurants that you visited.",
               
               @"AboutSH4": @"",
               @"AboutH4": @"How can you contact us?",
               @"AboutT4": @"It's simple. Write to us via email hello@rundlr.com",
               
               
               // TERMS VIEW
               @"TermsTitle": @"TERMS AND CONDITIONS",
               
               @"TermsSH1": @"",
               @"TermsH1": @"",
               @"TermsT1": @"By using the services of Rundlr you agree:\nThe content on this site is for informational purposes only.\nRundlr disclaims all responsibility for any information that has become outdated since the last time the information  was updated.\n\nRundlr reserves the right to make changes and corrections at any part of the contents of this App at any time, without notice.\n\nRundlr does not guarantee the price level indicated or the availability of all items of the best choices in any restaurant.\n\nAll names of restaurants, items were assigned the best choices for people who work in the restaurant.\n\nUnless otherwise stated, all images and information contained in this website were authorized by persons assigned to the restaurant and are believed to be public domain, such as promotional materials, publicity photos and / or media.\n\nPlease send an email if you are the owner of copyright of any content on the Site and, in your opinion, the use of the material breaches, in any form, copyrigh law. In this case, please indicate the exact location of the content in question.",
               
               
               // POLICY VIEW
               @"PolicyTitle": @"PRIVACY POLICY",
               
               @"PolicySH1": @"",
               @"PolicyH1": @"",
               @"PolicyT1": @"At Rundlr we recognize and value your right to privacy and we are committed to protecting your privacy online. Our privacy policy is clearly explained in the lines below. We ask that, before providing us with any personal information, you carefully read this document. When using Rundlr, you agree to our use of your personal information, provided that such use is in accordance with this policy. If you do not agree to the terms of this policy, please do not use this App.",
               
               @"PolicySH2": @"What information do we collect?",
               @"PolicyH2": @"Unregistered users",
               @"PolicyT2": @"To take advantage of several features of Rundlr, we suggest that you register. If you prefer not to register, you can take advantage of the functions of the App that do not require registration.\nIf you choose not to register, the information obtained by us will be more limited. We will obtain, for example, your IP address to help diagnose problems with our server, administer the App and track usage statistics. The IP address may vary each visit you do or may always be the same, depending on your access.\n\nRegardless, it is extremely difficult to identify you through your IP address and we do try to do that. If you reach our Site through a link or advertisement on another site, we also note that information only to maximize our exposure on the Internet and understand the interests of our users. All this information is recorded and used only in a general way, i.e. it is added to our database to generate General reports on our users, but at no time in reports about a particular user.\n\nWe have established a partnership with Facebook to offer instant customization at Rundlr for Facebook members. If you have configured the instant customization as \"active\" in your Facebook privacy settings and used Facebook login, the Rundlr App will be customized to you when you visit, even if it's the first time you access the Rundlr App. Facebook provides the information provided in accordance with your Facebook privacy settings. This information may include your name, profile picture, gender, friends lists and any other information provided.",
               
               @"PolicySH3": @"",
               @"PolicyH3": @"Registered users",
               @"PolicyT3": @"The option of registering will allow you to add content on Rundlr. For example, you can write your own comments, and we may suspend any message that contains illegal or offensive content as one who promotes racism or prejudice or any other form of legal violation in accordance with national laws.\nIn addition, we may delete comments that indicate clearly a personal attack against an establishment.\n\nRegistering on Rundlr has the advantage of being able to customize your experience. The advantages of registration increases with time as we are getting to know each other and introducing new features. Make your registration and enjoy all the experiences that the Rundlr has to offer!\nUpon receiving your registration, we collect your personal information, in addition to the non-personal information described above. Such personal information may include data entered manually by you in our forms, such as your name, e-mail address, mailing address, telephone number, favourite restaurants, username and password.",
               
               @"PolicySH4": @"",
               @"PolicyH4": @"We do not sell your personal information to others.",
               @"PolicyT4": @"We do not share your information with anyone. In some parts of the Site there are links that redirect to other sites. If you are redirected to those same sites, there is the possibility of being collected personal information. These websites are not within our control and are not covered by this privacy policy. If it is found that your use of the Site is unlawful or damaging to others, we reserve the right to disclose your information obtained through the Site, to the extent that it is reasonably necessary in our opinion to prevent, remedy or take action in relation to such conduct.",
               
               @"PolicySH5": @"",
               @"PolicyH5": @"Use",
               @"PolicyT5": @"We will use your information only for the following purposes:\n\nTo send regular news and information about Rundlr. From time to time asking questions or asking for feedback for research purposes.",
               
               @"PolicySH6": @"",
               @"PolicyH6": @"Links",
               @"PolicyT6": @"Links to other sites are provided for Rundlr in good faith and for information only. The Rundlr disclaims any responsibility for material contained in any site linked to this Site.",
               
               
               //CREDITS VIEW
               @"CreditsTitle": @"CREDITS",
               
               @"CreditsSH1": @"",
               @"CreditsH1": @"What are credits?",
               @"CreditsT1": @"Credits are the currency of rundlr to reward registered users for all actions that promote rundlr and its participating restaurants.",
               
               @"CreditsSH2": @"",
               @"CreditsH2": @"What are credits for?",
               @"CreditsT2": @"The credits are used to take advantage of discounts at participating restaurants at rundlr Club network.",
               
               @"CreditsSH3": @"",
               @"CreditsH3": @"Who can take advantage of the credits?",
               @"CreditsT3": @"Only registered users can use the credits of rundlr Club..",
               
               @"CreditsSH4": @"",
               @"CreditsH4": @"Who can be a member of rundlr Club?",
               @"CreditsT4": @"All registered users are automatically members of rundlr  Club.",
               
               @"CreditsSH5": @"",
               @"CreditsH5": @"How to obtain credits?",
               @"CreditsT5": @"Credits are obtained by the actions that promote rundlr and participating restaurants.",
               
               @"CreditsSH6": @"",
               @"CreditsH6": @"What actions accumulate credits?",
               @"CreditsT6": @"Rate the app in the app store.\nShare the app on Facebook.\nShare restaurants on Facebook.\nShare the restaurants on Twitter.\nComment restaurants.\nRate the restaurants.",
               
               @"CreditsSH7": @"",
               @"CreditsH7": @"What is the value assigned to each action?",
               @"CreditsT7": @"Rate the app in the app store - 20 credits\nShare the app on Facebook - 3 credits\nShare a restaurant on Facebook - 3 credits\nShare a restaurant  on Twitter - 3 credits\nReview a restaurant - 3 credits\nComment useful for other users - 2 credits\nRate a restaurant - 5 credits\nLevel up user - 10 credits",
               
               @"CreditsSH8": @"",
               @"CreditsH8": @"How many credits are required to redeem a voucher?",
               @"CreditsT8": @"1000 credits = discount voucher of 10 €\n3000 credits = discount voucher of 40 €\n5000 credits = discount voucher of 80 €",
               
               @"CreditsSH9": @"",
               @"CreditsH9": @"When to redeem a voucher?",
               @"CreditsT9": @"Whenever the user wants to take advantage of the offers and has credits equivalent to the discount voucher desired.",
               
               @"CreditsSH10": @"",
               @"CreditsH10": @"How to redeem the vouchers?",
               @"CreditsT10": @"By sending an email to hello@rundlr.com requesting redemption of voucher intended.",
               
               @"CreditsSH11": @"",
               @"CreditsH11": @"How to get the voucher?",
               @"CreditsT11": @"The voucher is sent by email.",
               
               @"CreditsSH12": @"",
               @"CreditsH12": @"Where can I use the voucher?",
               @"CreditsT12": @"At participating restaurants which are part of rundlr Club program.",
               
               @"CreditsSH13": @"TERMS",
               @"CreditsH13": @"",
               @"CreditsT13": @"All members of rundlr Club can check your credits in your user profile.\nCredits are valid for two years.\nCredits are only available to members of rundlr Club for at least three months.\nCredits can not be transferred between members of rundlr Club.\nCredits can only be used for offers and discounts described in the program.\nThe benefits resulting from its use can be enjoyed by rundlr Club member or someone who decides this gift.\nIf deactivation profile no refund of credit in any form.\nYou can not change the value of the offer for cash.\nRundlr reserves the right to make changes and corrections to the program without notice.",
               
               
               // DAY MENU VIEW
               @"DayMenuTitle": @"DAILY MENU",
               @"DayMenuNotice": @"You are not following any daily menu.\n\nClick at daily menu at the restaurant profile you want to follow. That's it.",
               
               
               // TOP 10 VIEW
               @"Top10Title": @"TOP 10",
               
               
               // COMMENTS VIEW
               @"CommentsTitle": @"REVIEWS",
               
               
               // COMMENTS DETAIL VIEW
               @"DetailCommentsTitle": @"REVIEW",
               
               
               // NEWS VIEW
               @"NewsTitle": @"NEWS",
               @"NewsNotice": @"You are not following any restaurant's news.\n\nClick at news at the restaurant profile you want to follow. That's it.",
               
               
               // GLOBAIS
               @"GlobalFechar": @"Close",
               @"GlobalYes": @"Yes",
               @"GlobalNo": @"No",
               @"GlobalOk": @"OK",
               
               @"GlobalComErrorTitle": @"Communication error.",
               @"GlobalComErrorText": @"Check your internet connection and try again.",
               
               @"GlobalLocalErrorTitle": @"Error.",
               @"GlobalLocalErrorText": @"Activate location services.",
               
               @"GlobalNoSMS": @"Your device does not support sms.",
               
               @"GlobalNoEmail": @"Your device does not have the e-mail configured.",
               
               @"GlobalInterest": @"Hi Rundlr, \n\n I would like to follow the daily menu of %@ \n Please show them my interest about this."
               };
    
    
    
    
    
    
    langES = @{
               // RATE
               @"RateText": @"Clasificación",
               @"RateLimpar": @"Borrar",
               @"RateVotar": @"Votar",
               
               
               //FACE
               @"FaceDefault": @"Estoy utilizando #Rundlr para descubrir maravillosos restaurantes. Puedes descargar la aplicación gratuita para iOS Rundlr: http://itunes.apple.com/us/rundlr",
               @"FaceDefaultRest": @"%@\n%@\nAcabo de descubrir este maravilloso restaurante en #Rundlr. Descubrelo tu también.",
               @"FaceText": @"Estoy utilizando #Rundlr para descubrir maravillosos restaurantes. Puedes descargar la aplicación gratuita para iOS Rundlr: http://itunes.apple.com/us/rundlr",
               
               // MAIN VIEW
               @"MainExplore": @"BUSCAR ",
               @"MainFrase1": @"Buscar restaurante",
               @"MainFrase2": @"por lugar",
               @"MainPesquise": @"ENCONTRAR",
               @"MainFrasePesquise": @"Encontrar algo más específico por palabras clave.",
               @"MainTop10": @"TOP 10",
               @"MainComent": @"OPINIONES",
               @"MainMenu": @"MENU DEL DIA",
               @"MainNoticias": @"NOTICIAS",
               @"MainVouchers": @"PROMO",
               @"MainLogin": @"ENTRAR",
               @"MainNumC": @"Opiniones",
               @"MainNumF": @"Seguidores",
               
               
               // RESTAURANTES
               @"RestInfo": @"INFO",
               @"RestLocal": @"LUGAR",
               @"RestMenu": @"MENU",
               @"RestComent": @"OPINIONES",
               @"RestVotes": @"",
               @"RestCall": @"Llamar",
               
               @"RestFollowNews": @"Seguir noticias",
               @"RestFollowMenu": @"Seguir menu del dia",
               @"RestFollowVouchers": @"Seguir promociones",
               @"RestFollowComments": @"Seguir comentarios",
               
               @"RestShareSMS": @"Compartir por sms",
               @"RestShareEmail": @"Compartir por correo",
               @"RestShareFace": @"Compartir por Facebook",
               
               @"RestShareTwitter": @"Compartir por Twitter",
               @"RestNaoaderente": @"Este restaurante todavia no proporciona esta información.\nHaz clic y muéstrale tu interés.",
               
               @"RestAgite": @"Agitar el teléfono para obtener outra sugestión aleatoria.\nY así sucessivamente...",
               @"RestMarcar": @"Llamar %d?",
               
               @"RestShareSMSText": @"Acabo de descubrir %@ en Rundlr.",
               @"RestShareEmailText": @"Acabo de descubrir %@ en Rundlr.",
               @"RestShareTweetText": @"Acabo de descubrir %@ en #Rundlr.",
               
               @"RatingSelectValue": @"Por favor deje su clasificación.",
               
               @"RestNotify": @"El menú del día están ya disponibles para consulta",
               
               
               // RESTAURANTES INFO
               @"InfoRestImages": @"Galería de fotos",
               @"InfoRestChef": @"Chef",
               @"InfoRestDesc": @"Quiénes somos",
               @"InfoRestMorada": @"Dirección",
               @"InfoRestCozinhas": @"Cocina",
               @"InfoRestPreco": @"Precio medio por persona",
               @"InfoRestHora": @"Horario",
               @"InfoRestPaga": @"Pagamiento",
               @"InfoRestOutros": @"Opciones adicionales",
               @"InfoRestInfo":  @"INFORMACIÓN",
               
               
               // RESTAURANTES LOCAL
               @"LocalRestDir":  @"Cómo llegar",
               
               
               // RESTAURANTES ESCOLHAS
               @"ChoicesRestBest": @"MEJORES PLATOS",
               @"ChoicesRestMenu": @"MENU DEL DIA",
               
               
               //RESTAURANTES COMENTARIO
               @"ComRestComente": @"Comentar",
               
               
               // RESTAURANTES UPLOAD COMENTARIO
               @"UpComRestComText": @"Comentar el restaurante",
               @"UpComRestSend": @"Comentar",
               
               
               // SETTINGS CIDADES
               @"SettingsCities": @"Ciudad",
               @"SettingsSearch": @"Encontrar",
               
               
               // SETTINGS GERAIS
               @"SettingsDef": @"CONFIGURACIÓN",
               @"SettingsShare": @"COMPARTIR",
               @"SettingsRundlr": @"RUNDLR APP",
               
               @"SettingsLogin": @"Entrar",
               @"SettingsLogout": @"Salir",
               @"SettingsLang": @"Idioma",
               
               @"SettingsShareFace": @"Compartir en Facebook",
               @"SettingsTell": @"Contar a un amigo",
               
               @"SettingsRate": @"Puntuar la app",
               @"SettingsContact": @"Contáctanos",
               @"SettingsAbout": @"Quiénes somos",
               @"SettingsTerms": @"Términos y condiciones",
               @"SettingsPrivacy": @"Política de privacidad",
               
               @"SettingsTellSubject": @"Rundlr App",
               @"SettingsTellMessage": @"Estou a usar a Rundlr para descobrir restaurantes maravilhosos. Podes fazer o download gratuito da Rundlr app para iOS em: http://itunes.apple.com/us/rundlr",
               
               @"SettingsContactSubject": @"Rundlr App",
               @"SettingsContactMessage": @"Estoy utilizando Rundlr para descubrir maravillosos restaurantes. Puedes descargar la aplicación gratuita para iOS Rundlr: http://itunes.apple.com/us/rundlr",
               
               
               // EXPLORE VIEW
               @"ExploreRefresh": @"...",
               
               @"ExploreTitle": @"BUSCAR ",
               @"ExploreThisLocation": @"ESTA LOCALIZACIÓN",
               @"ExploreRefreshLabel": @"REFRESH",
               @"ExploreNear": @"CERCA DE MÍ",
               @"ExploreNearText": @"Lista de restaurantes cerca de mí",
               @"ExploreRandom": @"ALEATORIO",
               @"ExploreRandomText": @"Obtenga una sugestión aleatoria cerca de usted",
               @"ExploreOtherLocation": @"OTRO LUGAR",
               
               
               // SEARCH VIEW
               @"SearchHint1": @"Dica:",
               @"SearchHint2": @"Bacalao, Grill, Terraza, Wi-Fi\no lo primero que viene a la mente...",
               @"SearchTitle": @"ENCONTRAR",
               @"SearchRecent": @"BÚSQUEDAS RECIENTES",
               
               
               // RESULTS VIEW
               @"ResultsOpenTime": @"Abierto (%@)",
               
               @"ResultsTitle": @"RESULTADOS",
               
               @"ResultsCozinhas": @"COCINA",
               @"ResultsSearch": @"Buscar",
               @"ResultsOk": @"OK",
               @"ResultsLimpar": @"BORRAR",
               @"ResultsOrderBy": @"ORDENAR POR",
               @"ResultsOrderPop": @"Popularided",
               @"ResultsOrderVote": @"Clasificación",
               @"ResultsCuisineType": @"Tipo de cocina",
               @"ResultsFiltrarPor": @"FILTRAR POR",
               @"ResultsPreco": @"PRECIO POR PERSONA",
               @"ResultsOpcoesAdicionais": @"OPCIONES ADICIONALES",
               @"ResultsDelivery": @"Entrega",
               @"ResultsNight": @"Vida nocturna",
               @"ResultsTake": @"Para llevar",
               @"ResultsPrice1": @"< 15",
               @"ResultsPrice2": @"< 30",
               @"ResultsPrice3": @"< 50",
               @"ResultsPrice4": @"> 50",
               @"ResultsFilter": @"FILTRAR",
               @"ResultsDataConfirm": @"Confirmar",
               @"ResultsDateClose": @"Cerrar",
               @"ResultsNotice": @"No hay resultados para esta búsqueda.\n\nPor favor pruebe con otra palabra clave.",
               
               
               // USER
               @"UserInfo": @"INFO",
               @"UserNet": @"RED",
               @"UserListas": @"LISTA",
               @"UserComent": @"OPINIONES",
               @"UserEditarPerfil": @"Editar Perfil",
               @"UserCredits": @"%d Creditos",
               @"UserFollow": @"Seguir",
               
               
               // USER INFO
               @"InfoUserRecent": @"ACTIVIDAD RECIENTE",
               @"InfoUserComent": @"%d Opiniones.",
               @"InfoUserSeguidores": @"%d seguidores.",
               
               
               //USER NETWORK
               @"NetUserFollowers": @"Seguido por",
               @"NetUserFollowing": @"A seguir",
               
               
               //USER LISTS
               @"ListsUserFav": @"Favoritos",
               @"ListsUserBeen": @"Estuve alli",
               
               
               // LOGIN VIEW
               @"LoginFace": @"Entrar con Facebook",
               @"LoginNoticeFace": @"No te preocupes, nunca publicaremos en Facebook sin tu permiso.",
               
               
               //VOUCHERS VIEW
               @"VouchersSoon": @"Estamos corriendo detrás de las mejores ofertas.\n\nNos comprometemos a ser breves.",
               
               
               //ABOUT VIEW
               @"AboutTitle": @"Quiénes somos",
               
               @"AboutSH1": @"",
               @"AboutH1": @"¿Qué es Rundlr?",
               @"AboutT1": @"Rundlr es una plataforma en línea que te permite explorar un conjunto de los mejores restaurantes de la ciudad y encontrar aquellos que cumplen con sus deseos. Un restaurante clásico, un típico, un restaurante de comida internacional o un vegetariano, una casa de tapas, todo confluye en Rundlr para proporcionar momentos de placer en la mesa.",
               
               @"AboutSH2": @"",
               @"AboutH2": @"¿Cómo funciona Rundlr?",
               @"AboutT2": @"No importa lo que buscas, Rundlr lo encontrará.\n\nCon Rundlr, piensas, escribes y obtienes resultados por preferencia o búsqueda inteligente por plato, proximidad, servicios, ofertas, o puedes dejarte sorprender por una sugerencia aleatoria.\n\nCon Rundlr puedes crear alertas para recibir los menús del día de los restaurantes que pretendas seguir, estar al tanto de los acontecimientos de los restaurantes, crear de un perfil de usuario, seguir a otros usuarios y contar con información sobre las evaluaciones realizadas por ellos, crear su propia línea de tiempo y adquirir créditos a través de acciones de promoción de los restaurantes, aprovechando los créditos después a través de vales de descuento.",
               
               @"AboutSH3": @"",
               @"AboutH3": @"¿Quién utiliza Rundlr?",
               @"AboutT3": @"Rundlr es utilizada por usuarios experimentados de Internet en busca de opciones para comer.\n\nÚnete a Rundlr tu también. Averigua lo que está sucediendo, comparte tu opinión e inspira a más personas a conocer los restaurantes que has visitado.",
               
               @"AboutSH4": @"",
               @"AboutH4": @"¿Cómo puedes ponerte en contacto con nosotros?",
               @"AboutT4": @"Es simple. Escríbenos por correo electrónico hello@rundlr.com",
               
               
               // TERMS VIEW
               @"TermsTitle": @"Términos y condiciones",
               
               @"TermsSH1": @"",
               @"TermsH1": @"",
               @"TermsT1": @"Mediante el uso de los servicios de Rundlr, acuerda con lo siguiente:\n\nEl contenido en este sitio es sólo para fines informativos.\nRundlr exime toda responsabilidad por cualquier información que se ha convertido en obsoleta desde la última vez que la información actualizada.\n\nRundlr se reserva el derecho de realizar cambios y correcciones en cualquier parte de los contenidos de este sitio en cualquier momento, sin previo aviso.\n\nRundlr no garantiza los precios indicados o la disponibilidad de todos los artículos de las mejores opciones en cualquier restaurante.\n\nTodos los nombres de los restaurantes, los artículos y las mejores opciones fueran cedidas por personas que trabajan en el restaurante.\n\nA menos que se indique lo contrario, todas las imágenes y la información contenida en este sitio Web han sido autorizados por las personas asignadas al restaurante y se cree que son de dominio público, como materiales promocionales, fotos de publicidad y/o medios de comunicación.\n\nPor favor envíe un correo electrónico si usted es el dueño de los derechos de autor de cualquier contenido en el Sitio y, en su opinión, el uso de la violación del contenido, en cualquier forma, la ley de derechos de autor. En este caso, por favor indique la ubicación exacta del contenido en cuestión.",
               
               
               // POLICY VIEW
               @"PolicyTitle": @"POLÍTICA DE PRIVACIDAD",
               
               @"PolicySH1": @"",
               @"PolicyH1": @"",
               @"PolicyT1": @"Rundlr reconoce y valora su derecho a la intimidad, por lo que se compromete a proteger su privacidad online. Nuestra política de privacidad se explica claramente en las líneas abajo. Les pedimos que, antes de facilitarnos cualquier información personal, por favor lea este documento. Mediante el uso de Rundlr acepta nuestro uso de su información personal, siempre que tal uso sea de conformidad con esta política. Si usted no está de acuerdo con los términos de esta política, por favor no utilice este Sitio.",
               
               @"PolicySH2": @"¿Qué información se recopila?",
               @"PolicyH2": @"Usuarios sin registro",
               @"PolicyT2": @"Para beneficiarse de varias características de Rundlr, le sugerimos que se registre. Si prefiere no registrarse, puede el usuario tomar ventaja de las funciones de la web que no requiere registro.\nSi el usuario decide no registrarse, la información obtenida por nosotros será más limitada. Obtener, por ejemplo, su dirección IP para ayudar a diagnosticar problemas con nuestro servidor, administrar el sitio y las estadísticas de uso de la pista. La dirección IP puede variar en cada visita o puede ser la misma, en función de su acceso.\n\nNo obstante, es muy difícil identificar el usuario a través de su dirección IP y no lo hacemos. Si el usuario viene a nuestro sitio a través de un vínculo o un anuncio de otro sitio, observamos también la información sólo para maximizar nuestra exposición en Internet y para conocer los intereses de nuestros usuarios. Toda esta información se registra y se usa sólo de manera general, es decir, que se agrega a la base de datos para generar informes generales sobre nuestros usuarios, pero en ningún momento en los informes acerca de un usuario en particular.\n\nNos hemos asociado con Facebook para ofrecer la personalización instantánea en Rundlr para los miembros de Facebook. Si el usuario configura la personalización instantánea como \"activo\" en su configuración de privacidad de Facebook y conectado a Facebook, Rundlr se personalizará para el usuario  al visitar, incluso si es la primera vez que acceda a Rundlr. Facebook ofrece la información proporcionada de conformidad con la configuración de privacidad de Facebook. Esta información puede incluir su nombre, foto de perfil, género, listas de amigos y cualquier otra información disponible.",
               
               @"PolicySH3": @"",
               @"PolicyH3": @"Usuarios con registro",
               @"PolicyT3": @"La opción de registro se agregará contenido Rundlr. Por ejemplo, puede escribir sus propios comentarios, y podemos nosotros suspender cualquier mensaje que contenga contenidos ilegales u ofensivos como uno que promueve el racismo o el prejuicio o cualquier otra forma de violación legal de conformidad con las leyes nacionales.\n\nAdemás, es posible eliminar los comentarios que indican claramente un ataque personal contra un establecimiento.\nCuando usted se registra en Rundlr tiene la ventaja de ser capaz de personalizar su experiencia. Las ventajas del registro incrementan con el tiempo y siempre con la introducción de nuevas características. Regístrese y disfrute de todas las experiencias que Rundlr tiene que ofrecer!\nAl recibir su registro, recopilamos su información personal, además de la información de carácter no personal descrita anteriormente. Esta información personal puede incluir datos introducidos manualmente por el usuario en nuestros formularios, como su nombre, correo electrónico, dirección postal, número de teléfono, restaurantes favoritos, el nombre de usuario y contraseña.",
               
               @"PolicySH4": @"",
               @"PolicyH4": @"No vendemos su información personal a terceros.",
               @"PolicyT4": @"No compartimos su información con nadie. En algunas partes del sitio existen enlaces que redirigen a otros sitios. Si se dirige a estos mismos sitios, existe la posibilidad que información personal sea recogida. Estos sitios no están bajo nuestro control y no están cubiertos por esta política de privacidad. Si se verifica que el uso del sitio es ilegal o perjudicial para otros usuarios, nos reservamos el derecho de revelar su información obtenida a través del sitio, en la medida en que sea razonablemente necesaria en nuestra opinión para prevenir, remediar o tomar medidas en relación con la conducta.",
               
               @"PolicySH5": @"",
               @"PolicyH5": @"Uso",
               @"PolicyT5": @"Usaremos su información sólo para los fines siguientes:\n\nPara enviar información y noticias regulares de Rundlr. Para hacer preguntas o pedir información con fines de investigación.",
               
               @"PolicySH6": @"",
               @"PolicyH6": @"Enlaces",
               @"PolicyT6": @"Los enlaces a otros sitios se proporcionan por Rundlr de buena fe y son tan sólo de carácter informativo. Rundlr se exime de cualquier responsabilidad por el material contenido en cualquier sitio vinculado a este sitio.",
               
               
               //CREDITS VIEW
               @"CreditsTitle": @"CRÉDITOS",
               
               @"CreditsSH1": @"",
               @"CreditsH1": @"¿Qué son los créditos?",
               @"CreditsT1": @"Los créditos son la moneda de rundlr para recompensar a los usuarios registrados de todas las acciones que promueven rundlr y sus restaurantes participantes.",
               
               @"CreditsSH2": @"",
               @"CreditsH2": @"¿Para qué sirven los créditos?",
               @"CreditsT2": @"Los créditos se utilizan para aprovechar los descuentos en los restaurantes participantes de la red rundlr Club.",
               
               @"CreditsSH3": @"",
               @"CreditsH3": @"¿Quién puede beneficiarse de los créditos?",
               @"CreditsT3": @"Sólo los usuarios registrados pueden utilizar los créditos rundlr Club.",
               
               @"CreditsSH4": @"",
               @"CreditsH4": @"¿Quién puede ser miembro del Club de rundlr?",
               @"CreditsT4": @"Todos los usuarios registrados son automáticamente miembros rundlr Club.",
               
               @"CreditsSH5": @"",
               @"CreditsH5": @"¿Cómo se obtienen los créditos?",
               @"CreditsT5": @"Se obtienen por las acciones que promueven rundlr y restaurantes participantes.",
               
               @"CreditsSH6": @"",
               @"CreditsH6": @"¿Cuáles son las acciones que se van acumulando créditos?",
               @"CreditsT6": @"Clasificar de la aplicación en la App Store.\nCompartir la aplicación en Facebook.\nCompartir los restaurantes en Facebook.\nCompartir en restaurantes Twitter.\nComentar los restaurantes.\nClasificar los restaurantes.",
               
               @"CreditsSH7": @"",
               @"CreditsH7": @"¿Cuál es el valor asignado a cada acción?",
               @"CreditsT7": @"Clasificar de la aplicación en la App Store - 20 créditos\nCompartir la aplicación en Facebook - 3 créditos\nCompartir un restaurante en Facebook - 3 créditos\nCompartir un restaurante en Twitter - 3 créditos\nRevisar un restaurante - 3 créditos\nComentario útil para otros usuarios - 2 créditos\nClasificar de un restaurante - 5 créditos\nSubir de nivel de usuario - 10 créditos",
               
               @"CreditsSH8": @"",
               @"CreditsH8": @"¿Cuántos créditos se requieren para canjear un cupón?",
               @"CreditsT8": @"1000 créditos = cupón de descuento de 10 €\n3000 créditos = cupón de descuento de 40 €\n5000 créditos = cupón de descuento de 80 €",
               
               @"CreditsSH9": @"",
               @"CreditsH9": @"Cuando se puede canjear un cupón?",
               @"CreditsT9": @"Cada vez que el usuario desea tomar ventaja de las ofertas y tiene créditos equivalentes al cupón de descuento que desee.",
               
               @"CreditsSH10": @"",
               @"CreditsH10": @"Cómo canjear un cupón?",
               @"CreditsT10": @"Mediante el envío de un correo electrónico a hello@rundlr.com solicitar la redención de los vales previsto.",
               
               @"CreditsSH11": @"",
               @"CreditsH11": @"¿Cómo obtener el cupón?",
               @"CreditsT11": @"El cupón se enviará por correo electrónico.",
               
               @"CreditsSH12": @"",
               @"CreditsH12": @"¿Dónde puedo usar los cupones?",
               @"CreditsT12": @"En los restaurantes participantes en el programa rundlr Club.",
               
               @"CreditsSH13": @"Condiciones",
               @"CreditsH13": @"",
               @"CreditsT13": @"Todos los miembros del rundlr Club pueden ver sus créditos en su perfil de usuario.\nLos créditos son válidos por dos años.\nLos créditos están disponibles sólo para los miembros del rundlr Club durante al menos tres meses.\nLos créditos no pueden transferirse entre los miembros rundlr Club.\nLos créditos sólo pueden ser utilizados para ofertas y descuentos descritos en el programa.\nLos beneficios derivados de su uso puede ser disfrutado por los miembros del rundlr Club o alguien que reciba este regalo.\nEn caso de desactivación del perfil no hay devolución del crédito en cualquier forma.\nNo se puede cambiar el valor de la oferta en efectivo.\nRundlr se reserva el derecho de realizar cambios y correcciones en el programa sin previo aviso.",
               
               
               // DAY MENU VIEW
               @"DayMenuTitle": @"MENU DEL DIA",
               @"DayMenuNotice": @"Aún no sigues cualquier menu del día.\n\n Haz clic en el perfil de los restaurantes que quieres seguir. Ya esta!",
               
               
               // TOP 10 VIEW
               @"Top10Title": @"TOP 10",
               
               
               // COMMENTS VIEW
               @"CommentsTitle": @"OPINIONES",
               
               
               // COMMENTS DETAIL VIEW
               @"DetailCommentsTitle": @"OPINION",
               
               
               // NEWS VIEW
               @"NewsTitle": @"NOTICIAS",
               @"NewsNotice": @"Aún no sigues las novedades de cualquier restaurante.\n\nHaz clic en novedades en el perfil de los restaurantes que quieres seguir. Ya esta!",
               
               
               // GLOBAIS
               @"GlobalFechar": @"Cerrar",
               @"GlobalYes": @"Si",
               @"GlobalNo": @"No",
               @"GlobalOk": @"OK",
               
               @"GlobalComErrorTitle": @"Error de comunicación.",
               @"GlobalComErrorText": @"Compruebe su conexión a internet y vuelva a intentarlo.",
               
               @"GlobalLocalErrorTitle": @"Error.",
               @"GlobalLocalErrorText": @"Active los servicios de localización.",
               
               @"GlobalNoSMS": @"Este equipo no soporta sms.",
               
               @"GlobalNoEmail": @"Este equipo no tiene el correo electrónico configurado.",
               
               @"GlobalInterest": @"Hola Rundlr, \n\n Me gustaria segui em menu del dia de %@ \n Muéstrale mi interés por favor."
               };
    
    
    
    
    
    
    
    // FRENCH LANGUAGE
    
    langFR = @{
               // RATE
               @"RateText": @"Votre score",
               @"RateLimpar": @"Effacer",
               @"RateVotar": @"Voter",
               
               
               //FACE
               @"FaceDefault": @"J'utilise #Rundlr pour découvrir de merveilleux restaurants. Téléchargez l'application gratuite Rundlr pour iOS: http://itunes.apple.com/us/rundlr",
               @"FaceDefaultRest": @"%@\n%@\nJe viens de découvrir ce merveilleux restaurant à #Rundlr. Découvrez vous aussi.",
               @"FaceText": @"J'utilise Rundlr pour découvrir de merveilleux restaurants. Téléchargez l'application gratuite Rundlr pour iOS: http://itunes.apple.com/us/rundlr",
               
               // MAIN VIEW
               @"MainExplore": @"EXPLORER",
               @"MainFrase1": @"Rechercher restaurant",
               @"MainFrase2": @"par adresse",
               @"MainPesquise": @"RECHERCHE",
               @"MainFrasePesquise": @"Rechercher par mot clé.",
               @"MainTop10": @"TOP 10",
               @"MainComent": @"COMMENT.",
               @"MainMenu": @"PLAT DU JOUR",
               @"MainNoticias": @"ACTUALITÉS",
               @"MainVouchers": @"VOUCHERS",
               @"MainLogin": @"CONNEXION",
               @"MainNumC": @"Commentaires",
               @"MainNumF": @"Adeptes",
               
               
               // RESTAURANTES
               @"RestInfo": @"INFO",
               @"RestLocal": @"PLAN",
               @"RestMenu": @"MENU",
               @"RestComent": @"COMMENT.",
               @"RestVotes": @"",
               @"RestCall": @"Appeller",
               
               @"RestFollowNews": @"Suivre les nouvelles",
               @"RestFollowMenu": @"Suivre le plat du jour",
               @"RestFollowVouchers": @"Suivre les vouchers",
               @"RestFollowComments": @"Suivre les commentaires",
               
               @"RestShareSMS": @"Partager par sms",
               @"RestShareEmail": @"Partager par email",
               @"RestShareFace": @"Partager en Facebook",
               
               @"RestShareTwitter": @"Partager en Twitter",
               @"RestNaoaderente": @"Ce restaurant ne fournit pas encore cette information.\nMontrez votre intérêt.",
               
               @"RestAgite": @"Agitez pour obtenir autre suggestion aléatoire.\nEt ainsi de suite...",
               @"RestMarcar": @"Appeller %d?",
               
               @"RestShareSMSText": @"Je viens de découvrir %@ à Rundlr.",
               @"RestShareEmailText": @"Je viens de découvrir %@ à Rundlr.",
               @"RestShareTweetText": @"Je viens de découvrir %@ à #Rundlr.",
               
               @"RatingSelectValue": @"Donnez votre score s'il vous plâit.",
               
               @"RestNotify": @"Les plats du jours sont déjà disponibles pour consultation",
               
               
               // RESTAURANTES INFO
               @"InfoRestImages": @"Galerie de photos",
               @"InfoRestChef": @"Chef",
               @"InfoRestDesc": @"A propos de nous",
               @"InfoRestMorada": @"Adresse",
               @"InfoRestCozinhas": @"Cuisine",
               @"InfoRestPreco": @"Prix moyen par personne",
               @"InfoRestHora": @"Horaires",
               @"InfoRestPaga": @"Payment",
               @"InfoRestOutros": @"Options additionnelles",
               @"InfoRestInfo":  @"INFORMATION",
               
               
               // RESTAURANTES LOCAL
               @"LocalRestDir":  @"Obtenir les directions",
               
               
               // RESTAURANTES ESCOLHAS
               @"ChoicesRestBest": @"MEUILLERS PLATS",
               @"ChoicesRestMenu": @"PLAT DU JOUR",
               
               
               //RESTAURANTES COMENTARIO
               @"ComRestComente": @"Commenter",
               
               
               // RESTAURANTES UPLOAD COMENTARIO
               @"UpComRestComText": @"Commenter le restaurant",
               @"UpComRestSend": @"Commenter",
               
               
               // SETTINGS CIDADES
               @"SettingsCities": @"Villes",
               @"SettingsSearch": @"Recherche",
               
               
               // SETTINGS GERAIS
               @"SettingsDef": @"RÉGLAGES",
               @"SettingsShare": @"PARTAGER",
               @"SettingsRundlr": @"RUNDLR APP",
               
               @"SettingsLogin": @"Connexion",
               @"SettingsLogout": @"Déconnexion",
               @"SettingsLang": @"Langue",
               
               @"SettingsShareFace": @"Partager au Facebook",
               @"SettingsTell": @"Parlez-en à un ami.",
               
               @"SettingsRate": @"Classer l'application",
               @"SettingsContact": @"Contacter",
               @"SettingsAbout": @"Qui sommes-nous",
               @"SettingsTerms": @"Térmes et conditions",
               @"SettingsPrivacy": @"Politique de privacité",
               
               @"SettingsTellSubject": @"Rundlr App",
               @"SettingsTellMessage": @"J'utilise Rundlr pour découvrir de merveilleux restaurants. Téléchargez l'application gratuite Rundlr pour iOS: http://itunes.apple.com/us/rundlr",
               
               @"SettingsContactSubject": @"Rundlr App",
               @"SettingsContactMessage": @"J'utilise Rundlr pour découvrir de merveilleux restaurants. Téléchargez l'application gratuite Rundlr pour iOS: http://itunes.apple.com/us/rundlr",
               
               
               // EXPLORE VIEW
               @"ExploreRefresh": @"...",
               
               @"ExploreTitle": @"EXPLORER",
               @"ExploreThisLocation": @"VOTRE LOCALIZATION",
               @"ExploreRefreshLabel": @"REFRESH",
               @"ExploreNear": @"AUTOUR DE MOI",
               @"ExploreNearText": @"Liste de restaurants autour de moi",
               @"ExploreRandom": @"ALÉATOIRE",
               @"ExploreRandomText": @"Obtenir une suggestion aléatoire autour de moi",
               @"ExploreOtherLocation": @"AUTRE LOCALIZATION",
               
               
               // SEARCH VIEW
               @"SearchHint1": @"Suggestion:",
               @"SearchHint2": @"Morue, Grill, Terrasse, Wi-Fi\nou ce qui vient à l'esprit...",
               @"SearchTitle": @"RECHERCHE",
               @"SearchRecent": @"RECHERCHES RÉCENTS",
               
               
               // RESULTS VIEW
               @"ResultsOpenTime": @"Ouvert (%@)",
               
               @"ResultsTitle": @"RÉSULTATS",
               
               @"ResultsCozinhas": @"CUISINES",
               @"ResultsSearch": @"Recherche",
               @"ResultsOk": @"OK",
               @"ResultsLimpar": @"EFFACER",
               @"ResultsOrderBy": @"Ordonner par",
               @"ResultsOrderPop": @"Popularité",
               @"ResultsOrderVote": @"Classification",
               @"ResultsCuisineType": @"Type de cuisine",
               @"ResultsFiltrarPor": @"FILTRER PAR",
               @"ResultsPreco": @"PRIX PAR PERSONNE",
               @"ResultsOpcoesAdicionais": @"OPTIONS ADDITIONNELLES",
               @"ResultsDelivery": @"Livraison",
               @"ResultsNight": @"Vie nocturne",
               @"ResultsTake": @"À emporter",
               @"ResultsPrice1": @"< 15",
               @"ResultsPrice2": @"< 30",
               @"ResultsPrice3": @"< 50",
               @"ResultsPrice4": @"> 50",
               @"ResultsFilter": @"FILTRER",
               @"ResultsDataConfirm": @"Confirmer",
               @"ResultsDateClose": @"Fermer",
               @"ResultsNotice": @"Pas de résultat pour cette recherche.\n\nVeuillez essayer un autre mot-clé.",
               
               
               // USER
               @"UserInfo": @"INFO",
               @"UserNet": @"RÉSEAU",
               @"UserListas": @"LISTE",
               @"UserComent": @"COMMENT.",
               @"UserEditarPerfil": @"Éditer profil",
               @"UserCredits": @"%d Credits",
               @"UserFollow": @"Suivre",
               
               
               // USER INFO
               @"InfoUserRecent": @"ACTIVITÉ RÉCENTE",
               @"InfoUserComent": @"%d commentaires.",
               @"InfoUserSeguidores": @"%d adeptes.",
               
               
               //USER NETWORK
               @"NetUserFollowers": @"Suivie par",
               @"NetUserFollowing": @"A suivre",
               
               
               //USER LISTS
               @"ListsUserFav": @"Favourites",
               @"ListsUserBeen": @"Étè là",
               
               
               // LOGIN VIEW
               @"LoginFace": @"Se connecter avec Facebook",
               @"LoginNoticeFace": @"Ne vous inquiétez pas, nous ne l'afficherons jamais rien à Facebook sans votre permission.",
               
               
               //VOUCHERS VIEW
               @"VouchersSoon": @"Nous recherchons les meilleures offres.\n\nNous promettons d'être bref pour trouver des offres à ne pas manquer.",
               
               
               //ABOUT VIEW
               @"AboutTitle": @"À PROPOS DE NOUS",
               
               @"AboutSH1": @"",
               @"AboutH1": @"Qui sommes-nous?",
               @"AboutT1": @"Rundlr est une plateforme en ligne qui vous permet d'explorer un ensemble des meilleurs restaurants de la ville et de trouver ceux qui répondent à vos désirs. Un restaurant classique, un typique, un restaurant de cuisine internationale ou un végétarien tout est a Rundlr pour offrir des moments de plaisir à la table.",
               
               @"AboutSH2": @"",
               @"AboutH2": @"Comment fonctionne Rundlr?",
               @"AboutT2": @"Peu importe ce que vous cherchez, Rundlr le trouvera pour vous.\n\nAvec Rundlr, vous pensez, vous écrivez et vous obtenez des résultats par préférence, par la recherche intelligente, par plat, proximité, services, offres, ou vous pouvez vous laisser surprendre par une suggestion aléatoire.\n\nRundlr vous permet de créer des alertes pour recevoir des menus quotidiens des restaurants que vous voulez suivre, se tenir au courant des événements et des nouveaux restaurants, la création d'un profil utilisateur, suivre d'autres utilisateurs et des informations sur les évaluations faites par ceux-ci, créer votre propre ligne de temps et d'acquérir des crédits par des actions favorisant les restaurants, peuvent ensuite racheter les crédits à travers des bons de réduction.",
               
               @"AboutSH3": @"",
               @"AboutH3": @"Qui utilise Rundlr?",
               @"AboutT3": @"Rundlr est utilisé par des utilisateurs expérimentés de l'Internet à la recherche d'options pour dîner.\n\nRejoignez Rundlr vous aussi. Découvrez ce qui se passe, partagez votre opinion et inspirez plus de gens de connaître les restaurants que vous avez visités.",
               
               @"AboutSH4": @"",
               @"AboutH4": @"Comment pouvez-vous nous contacter?",
               @"AboutT4": @"Il est simple. Écrivez-nous par courrier électronique hello@rundlr.com",
               
               
               // TERMS VIEW
               @"TermsTitle": @"TERME ET CONDITIONS",
               
               @"TermsSH1": @"",
               @"TermsH1": @"",
               @"TermsT1": @"En utilisant les services Rundlr, vous acceptez:\n\nLe contenu de ce site est uniquement informatif.\nRundlr décline toute responsabilité pour tout renseignement qui est devenu obsolète depuis la dernière fois que l'information été mise à jour.\n\nRundlr se réserve le droit d'apporter des modifications et des corrections à tout ou partie des contenus de ce site à tout moment, sans préavis.\n\nRundlr ne garantit pas les prix indiqués ou la disponibilité de tous les articles de meilleurs choix dans n'importe quel restaurant.\n\nTous les noms des restaurants, les meilleurs choix ont été assignés pour les personnes qui travaillent dans le restaurant.\n\nSauf indication contraire, toutes les images et informations contenues dans ce site ont été autorisés par les personnes affectées au restaurant et sont considérées comme du domaine public, tels que du matériel promotionnel, des photos publicitaires et/ou des médias.\n\nVeuillez envoyer un e-mail si vous êtes le propriétaire du droit d'auteur de quelque contenu sur le Site et, à son avis, l'utilisation de la violation substantielle, sous quelque forme, le droit d'auteur. Dans ce cas, veuillez s'il vous plaît indiquer l'emplacement exact du contenu en question.",
               
               
               // POLICY VIEW
               @"PolicyTitle": @"POLITIQUE CONFIDENTIALITÉ",
               
               @"PolicySH1": @"",
               @"PolicyH1": @"",
               @"PolicyT1": @"Rundlr reconnaît et valorise votre droit à la vie privée et donc s'engage à protéger votre vie privée en ligne. Notre politique de confidentialité est clairement expliqué sur les lignes ci-dessous. Nous vous demandons, avant de nous fournir vos données personnels, de lire attentivement ce document. En utilisant Rundlr vous consentez à l'utilisation de vos renseignements personnels, à condition que cette utilisation soit conforme à cette politique. Si vous n'acceptez pas les termes de cette politique, veuillez s'il vous plaît ne pas utiliser ce Site.",
               
               @"PolicySH2": @"Quelles sont les informations que nous recueillons?",
               @"PolicyH2": @"Utilisateurs sans inscription",
               @"PolicyT2": @"Pour profiter de plusieurs fonctionnalités de Rundlr, nous vous suggérons de vous inscrire. Si vous préférez ne pas vous inscrire, vous pouvez profiter des fonctionnalités du Site qui ne nécessite pas d'inscription.\n\nSi vous choisissez de ne pas vous inscrire, les informations obtenues par nous seront plus limité. Nous obtenons, par exemple, votre adresse IP pour aider à diagnostiquer des problèmes avec notre serveur, administrer le site et les statistiques d'utilisation de la piste. L'adresse IP peut varier chaque visite  	ou peut être toujours le même, en fonction de votre accès.\n\nQuel que soit le type de visite en ligne, il est extrêmement difficile pour nous de vous identifier grâce à votre adresse IP et nous n'essayons pas de le faire. Si vous venez à notre site via un lien ou une annonce sur un autre site, nous notons également que des informations seulement pour maximiser notre présence sur Internet et de comprendre les intérêts de nos utilisateurs. Toutes ces informations sont enregistrées et utilisées que de manière générale, c'est à dire, ils sont ajoutés à notre base de données pour générer des rapports généraux sur nos utilisateurs, mais à aucun moment dans les rapports sur un utilisateur particulier.\n\nNous avons établi un partenariat avec Facebook pour proposer la personnalisation instantanée sur Rundlr pour les membres de Facebook. S'il est configuré personnalisation instantanée comme \"active\" dans leurs paramètres de confidentialité de Facebook et connecté à Facebook, Rundlr sera adapté pour vous lors de la visite, même si c'est la première fois que vous accédez à Rundlr. Facebook fournit des informations fournies conformément à vos paramètres de confidentialité sur Facebook. Ces informations peuvent inclure votre nom, votre photo de profil, le sexe, les listes d'amis et de toute autre information disponible.",
               
               @"PolicySH3": @"",
               @"PolicyH3": @"Utilisateurs disposant de l'enregistrement",
               @"PolicyT3": @"La possibilité d'enregistrer va ajouter du contenu dans Rundlr. Par exemple, vous pouvez écrire vos propres commentaires, par contre nous nous réservons le droit de supprimer sans préavis tout message qui contient un contenu illégal ou offensant comme celui qui favorise le racisme ou les préjugés ou toute autre forme de violation de la loi en conformité avec les lois nationales.\nEn outre, nous pouvons supprimer les commentaires qui indiquent clairement une attaque personnelle contre un établissement.\nLorsque vous vous inscrivez sur Rundlr a l'avantage d'être en mesure de personnaliser votre expérience. Les avantages de l'augmentation de l'enregistrement avec le temps et que nous connaissons les meilleurs et en introduisant de nouvelles fonctionnalités. Veuillez s'il vous plaît vous inscrire et profiter de toutes les expériences que Rundlr a à offrir!\nDès réception de votre inscription, nous recueillons vos renseignements personnels, en plus des informations non personnelles décrites ci-dessus. Ces renseignements personnels peuvent inclure des données saisies manuellement par vous dans nos formes, telles que votre nom, adresse email, adresse postale, numéro de téléphone, les restaurants préférés, nom d'utilisateur et mot de passe.",
               
               @"PolicySH4": @"",
               @"PolicyH4": @"Nous ne vendons pas vos informations personnelles à des tiers.",
               @"PolicyT4": @"Nous ne partageons pas vos informations avec n'importe qui. Dans certaines parties du site vous trouverez des liens qui redirigent vers d'autres sites. Si vous êtes dirigez vers ces mêmes sites, il est possible que des  renseignements personnels soins recueillis. Ces sites ne sont pas sous notre contrôle et ne sont pas couverts par cette politique de confidentialité. S'il est constaté que l'utilisation du Site est illégal ou préjudiciable aux autres utilisateurs, nous nous réservons le droit de divulguer vos informations obtenues par le site, dans la mesure qui est raisonnablement nécessaire à notre avis, pour prévenir, corriger ou prendre des mesures par rapport à ce comportement.",
               
               @"PolicySH5": @"",
               @"PolicyH5": @"Usage",
               @"PolicyT5": @"Nous allons utiliser vos renseignements uniquement aux fins suivantes:\n\nPour envoyer des nouvelles et information de Rundlr. Pour poser des questions ou demander des informations à des fins de recherche.",
               
               @"PolicySH6": @"",
               @"PolicyH6": @"Liens",
               @"PolicyT6": @"Liens vers d'autres sites sont fournis pour Rundlr de bonne foi et à titre indicatif. Rundlr décline toute responsabilité pour le matériel contenu dans un site lié à ce site.",
               
               
               //CREDITS VIEW
               @"CreditsTitle": @"CRÉDITS",
               
               @"CreditsSH1": @"",
               @"CreditsH1": @"Que sont les crédits?",
               @"CreditsT1": @"Les crédits sont la la méthode de paiement de rundlr pour récompenser les utilisateurs enregistrés de toutes les actions qui favorisent rundlr et ses restaurants participants.",
               
               @"CreditsSH2": @"",
               @"CreditsH2": @"À quoi servent les crédits?",
               @"CreditsT2": @"Les crédits sont utilisés pour profiter de réductions dans les restaurants participant au réseau rundlr Club.",
               
               @"CreditsSH3": @"",
               @"CreditsH3": @"Qui peut profiter des crédits?",
               @"CreditsT3": @"Seuls les utilisateurs enregistrés peuvent utiliser les crédits rundlr Club.",
               
               @"CreditsSH4": @"",
               @"CreditsH4": @"Qui peut être membre du rundlr Club?",
               @"CreditsT4": @"Tous les utilisateurs  inscrits sont automatiquement membres rundlr Club.",
               
               @"CreditsSH5": @"",
               @"CreditsH5": @"Comment sont obtenus les crédits?",
               @"CreditsT5": @"Sont obtenus par les actions qui favorisent rundlr et les restaurants participants.",
               
               @"CreditsSH6": @"",
               @"CreditsH6": @"Quelles sont les actions qui accumulent des crédits?",
               @"CreditsT6": @"Noter l'application dans l'App Store.\nPartagez l'application sur Facebook.\nPartagez les restaurants sur Facebook.\nPartager les restaurants sur Twitter.\nCommenter restaurants.\nTriez les restaurants.",
               
               @"CreditsSH7": @"",
               @"CreditsH7": @"Quelle est la valeur attribuée à chaque action?",
               @"CreditsT7": @"Noter l'application dans l'App Store - 20 crédits\nPartagez l'application sur Facebook - 3 crédits\nPartagez un restaurant sur Facebook - 3 crédits\nPartagez un restaurant sur Twitter - 3 crédits\nExaminer un restaurant - 3 crédits\nCommenter utile pour les autres utilisateurs - 2 crédits\nNoter un restaurant - 5 Crédits\nMonter de niveau utilisateur - 10 crédits",
               
               @"CreditsSH8": @"",
               @"CreditsH8": @"Combien de crédits sont tenus d'utiliser un coupon?",
               @"CreditsT8": @"1000 crédits = coupon de 10 €\n3000 crédits = coupon de 40 €\n5000 crédits = coupon de 80 €",
               
               @"CreditsSH9": @"",
               @"CreditsH9": @"Lorsque vous pouvez utiliser un coupon?",
               @"CreditsT9": @"Lorsque l'utilisateur veut profiter des offres et possède crédits équivalents au coupon souhaité.",
               
               @"CreditsSH10": @"",
               @"CreditsH10": @"Comment utiliser un coupon?",
               @"CreditsT10": @"En envoyant un courriel à hello@rundlr.com demandant le rachat de coupon prévu.",
               
               @"CreditsSH11": @"",
               @"CreditsH11": @"Comment faire pour obtenir le coupon?",
               @"CreditsT11": @"Le coupon est envoyé par courriel.",
               
               @"CreditsSH12": @"",
               @"CreditsH12": @"Où puis-je utiliser les coupons?",
               @"CreditsT12": @"Aux restaurants participants au programme rundlr Club.",
               
               @"CreditsSH13": @"TERMES",
               @"CreditsH13": @"",
               @"CreditsT13": @"Tous les membres du rundlr Club peuvent vérifier ses crédits dans leur profil d'utilisateur.\nLes crédits sont valables pendant deux ans.\nLes crédits ne sont accessibles qu'aux membres rundlr Club pendant au moins trois mois.\nLes crédits ne peuvent être transférés entre les membres rundlr Club.\nLes crédits ne peuvent être utilisés pour des offres et rabais décrits dans le programme.\nLes avantages résultant de leur utilisation peuvent être apprécié par les membres du rundlr Club ou quelqu'un qui décide de ce don.\nEn cas de désactivation il n'y a pas aucun remboursement de crédit dans n'importe quelle forme.\nVous ne pouvez pas modifier la valeur de l'offre pour de l'argent.\nRundlr se réserve le droit d'apporter des modifications et des corrections apportées au programme sans préavis.",
               
               // DAY MENU VIEW
               @"DayMenuTitle": @"PLAT DU JOUR",
               @"DayMenuNotice": @"Vous ne suivez pas encore un plat du jour.\n\nCliquez sur plat du jour sur le profil des restaurants qui vous voulez suivre. Voilà!",
               
               
               // TOP 10 VIEW
               @"Top10Title": @"TOP 10",
               
               
               // COMMENTS VIEW
               @"CommentsTitle": @"COMMENTAIRES",
               
               
               // COMMENTS DETAIL VIEW
               @"DetailCommentsTitle": @"COMMENTAIRE",
               
               
               // NEWS VIEW
               @"NewsTitle": @"ACTUALITÉS",
               @"NewsNotice": @"Vous ne suivez pas encore des nouvelles.\n\nCliquez sur nouvelles sur le profil des restaurants qui vous voulez suivre. Voilà!",
               
               
               // GLOBAIS
               @"GlobalFechar": @"Fermer",
               @"GlobalYes": @"Oui",
               @"GlobalNo": @"Non",
               @"GlobalOk": @"OK",
               
               @"GlobalComErrorTitle": @"Erreur de communication.",
               @"GlobalComErrorText": @" Vérifiez votre connexion internet et réessayez.",
               
               @"GlobalLocalErrorTitle": @"Erreur.",
               @"GlobalLocalErrorText": @"Activez les services de localisation.",
               
               @"GlobalNoSMS": @"Votre appareil ne supporte pas sms.",
               
               @"GlobalNoEmail": @"Le courrier electronique n'est pas configuré sur votre Appareil.",
               
               @"GlobalInterest": @"Salut Rundlr, \n\n J'aimerais suivre les plat du jour. %@ \nMontrez-lui mon intérêt s'il veut plâit."
               };
}

+ (NSString *)textForIndex:(NSString *)index
{
    
    if ([[Globals lang] isEqualToString:@"en"]) {
        return [langEN objectForKey:index];
    } else if ([[Globals lang] isEqualToString:@"es"]) {
        return [langES objectForKey:index];
    } else if ([[Globals lang] isEqualToString:@"fr"]) {
        return [langFR objectForKey:index];
    } else {
        return [langPT objectForKey:index];
    }
    
}

@end
