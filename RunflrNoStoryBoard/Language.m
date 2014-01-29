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
static NSDictionary *langIT = nil;
static NSDictionary *langDE = nil;



@implementation Language

+ (void)createLanguage
{

langPT = @{
               //dias da semana
               @"Segunda-feira": @"Segunda-feira",
               @"Terça-feira": @"Terça-feira",
               @"Quarta-feira": @"Quarta-feira",
               @"Quinta-feira": @"Quinta-feira",
               @"Sexta-feira": @"Sexta-feira",
               @"Sabado": @"Sábado",
               @"Domingo": @"Domingo",
			   
			   
                //1ª PÁGINA
			    @"Restaurante": @"Restaurante",
                @"Cidade": @"Cidade",
                @"Pesquisar": @"Pesquisar ",
                @"Meus_menus": @"Meus menus",
                @"Recomendados": @"Sugestões",
			    @"Favoritos": @"Meus favoritos",
			    @"Geolocalizacao": @"Active a geolocalização",
			    @"Obter_melhor_Menu_guru": @"para obter o melhor do Menu Guru",
				@"Texto_Activa_Geolocalizacao": @"Vá a definições, privacidade, serviços de localização e active este serviço para que possamos determinar a sua localização aproximada e sugerir-lhe os menus dos melhores restaurantes perto de si.",
				@"Adicione_Favoritos": @"Adicione Favoritos",
				@"Adicionar_lista_favoritos": @"para obter o melhor do Menu Guru",
                @"Adicionar_lista_fundo": @"Pesquise pela cidade ou nome do restaurante. Selecione o restaurante que pretende e adicione-o aos favoritos.",
				
				//2ªpagina resultados
				@"Todos": @"Todos",
				
				//1ª PÁGINA DE REFÚGIO
				@"Menu": @"Menu",
				@"Inicio": @"Início",
				@"Minha_conta": @"A minha conta",
				@"Definicoes": @"Definições",
				@"Idioma": @"Idioma",
				
				//2ª PÁGINA DE REFÚGIO/MINHA CONTA
				@"Ola": @"Olá",
				@"Conectado": @"Conectado",
				@"Receber_Notificacoes": @"Receber Notificações",
				@"Conectar_Facebook": @"Conectar Conta do Facebook",
				@"Receber_Newsletter": @"Receber Newsletter",
				@"Mudar_foto": @"Mudar fotografia",
				
				//3ª PÁGINA DE REFÚGIO/DEFINIÇÕES
				@"Sobre_Menu_Guru": @"Sobre o Menu Guru",
				@"Feedback": @"Feedback",
				@"Termos_condicoes": @"Termos e Condições",
				@"Politica_privacidade": @"Política de Privacidade",
				
				//4ª PÁGINA DE REFÚGIO/DEFINIÇÕES/FEEDBACK
				@"Diz_que_pensas": @"Diz-nos o que pensas",
				@"Classifica_App": @"Classifica a App",
				@"Partilha_com_amigos": @"Partilhar com os amigos",
				@"Facebook": @"Facebook",
				@"MsgFace": @"Estou a usar o Menu Guru para descobrir menus especiais de vários restaurantes. Visita o site e faz as tuas próprias descobertas.",
				@"Email": @"Email",
				@"MsgEmail": @"Estou a usar o Menu Guru para descobrir menus especiais de vários restaurantes. Visita o site e faz as tuas próprias descobertas.",
				@"SMS": @"SMS",
				@"MsgSMS": @"Estou a usar o Menu Guru para descobrir menus especiais de vários restaurantes. Visita o site e faz as tuas próprias descobertas.",
				//falta a parte do facebook mensagem
				
				//4ª PÁGINA DE REFÚGIO/IDIOMA
				@"Ingles": @"Inglês",
				@"Frances": @"Francês",
				@"Espanhol": @"Espanhol",
				@"Portugues": @"Português",
				@"Italiano": @"Italiano",
				@"Alemao": @"Alemão",
				
				//PÁGINA RESTAURANTE Falta Tudo traduzir
				@"Desculpe_restaurante_Sem_Menus_titulo": @"Sem menus",
				@"Desculpe_restaurante_Sem_Menus_desc": @"Este restaurante ainda não tem menus disponíveis. Clique aqui para nos mostrar o seu interesse.",
				@"Ligar": @"Ligar",
				@"Marcar": @"Marcar",
				@"Sim": @"Sim",
				@"Nao": @"Não",
				@"Add_favoritos": @"Adicionar aos favoritos",
                @"Remover_favoritos": @"Remover dos favoritos",

				//PÁGINA pesquisa não encontrada
				@"Desculpe_pesquisa_titulo": @"Não encontrado",
				@"Desculpe_pesquisa_desc": @"Não conseguimos encontrar nenhum resultado. Por favor tente com outra palavra chave.",
				
				//Página de Login|Registo
				@"Entre_titulo": @"Entre | Registe-se",
				@"Entre_registar": @"para ter acesso ao melhor do Menu Guru.",
				@"Login_facebook": @"Entrar com Facebook",
				@"OU": @"ou",
				@"Iniciar_sessao": @"Iniciar sessão",
				@"Email_invalido": @"Email inválido",
				@"Email": @"Email",
				@"Password": @"Password",
				@"Minimo_pass": @"A password tem de ter no minímo 6 caractéres",
				@"Termos_e_condicoes_registar": @"Ao registar a sua conta está a concordar com os nossos Termos & condições e Politica de Privacidade",
				@"Registar_Menu_Guru": @"Registar-se no Menu Guru",
				@"Esqueceu_password": @"Esqueceu-se da password?",
				@"Primeiro_Nome": @"Primeiro Nome",
				@"Ultimo_Nome": @"Último Nome",
				@"Homem": @"Homem",
				@"Mulher": @"Mulher",
				@"Cidade": @"Cidade",
				@"Data_Nascimento": @"Data de Nascimento",
				@"Email_LR": @"Email",
				@"Password": @"Password",
				@"Repita_password": @"Repita password",
				@"Criar_Registo": @"Criar Registo",
				@"Deve_Preencher_todos_campos.": @"Deve preencher todos os campos.",
                @"password_igual": @"A password não coincide.",
				
				//popups menus são sempre iguais qualquer seja o cartão que falte parte tania json_m_rest.php
				@"Procurar_menu_clique_mostre_interesse_titulo": @"Mostrar interesse",
				@"Procurar_menu_clique_mostre_interesse_descr": @"Este restaurante ainda não disponibiliza esta informação. Deseja mostrar o seu interesse?",
				
				//popups sem net
				@"Erro_de_ligacao": @"Erro de ligação",
				@"Ocorre_erro_internet": @"Verifique a sua ligação à internet e tente de novo.",
				
				//popups logout
				@"Logout_titulo": @"Aviso",
				@"Logout_descricao": @"Quer mesmo desconectar-se?",
				
				//popups nova imagem
				@"Escolha_uma_foto": @"Escolha uma fotografia",
				@"Galeria": @"Galeria",
				@"Camera": @"Câmera",
				@"Cancel_imagem": @"Cancelar",
				@"cartao_diaria": @"Menu do dia",
                @"cartao_ementa": @"Ementa",
                @"cartao_especial": @"Menus especiais",
               @"erro": @"Erro",
               @"menu_dia": @"Menu do dia",
               @"menu_especial": @"Menus especiais",
               @"menu_ementa": @"Ementa",
               
               };

    langEN = @{
               //dias da semana
               @"Segunda-feira": @"Monday",
               @"Terça-feira": @"Tuesday",
               @"Quarta-feira": @"Wednesday",
               @"Quinta-feira": @"Thursday",
               @"Sexta-feira": @"Friday",
               @"Sabado": @"Saturday",
               @"Domingo": @"Sunday",
			   
               //1ª PÁGINA
			    @"Restaurante": @"Restaurant",
                @"Cidade": @"City",
                @"Pesquisar": @"Search",
                @"Meus_menus": @"My menus",
                @"Recomendados": @"Suggestions",
			    @"Favoritos": @"My favourites",
			    @"Geolocalizacao": @"Enable geolocation",
			    @"Obter_melhor_Menu_guru": @"to get the best of Menu Guru.",
				@"Texto_Activa_Geolocalizacao": @"Go to settings, privacy, location services and activate this service so we can determine your approximate location and suggest the menus of the best restaurants around you.",
				@"Adicione_Favoritos": @"Add Favorites",
				@"Adicionar_lista_favoritos": @"to get the best of Menu Guru.",
               @"Adicionar_lista_fundo": @"Search by city or restaurant's name. Select the restaurant you want and add it to your favorites.",
				
				//2ªpagina resultados
				@"Todos": @"All",
				
				//1ª PÁGINA DE REFÚGIO
				@"Menu": @"Menu",
				@"Inicio": @"Home",
				@"Minha_conta": @"My account",
				@"Definicoes": @"Settings",
				@"Idioma": @"Language",
				
				//2ª PÁGINA DE REFÚGIO/MINHA CONTA
				@"Ola": @"Hello",
				@"Conectado": @"Connected",
				@"Receber_Notificacoes": @"Receive Notifications",
				@"Conectar_Facebook": @"Connect With Facebook",
				@"Receber_Newsletter": @"Receive Newsletter",
				@"Mudar_foto": @"Change photo",
				
				//3ª PÁGINA DE REFÚGIO/DEFINIÇÕES
				@"Sobre_Menu_Guru": @"About Menu Guru",
				@"Feedback": @"Feedback",
				@"Termos_condicoes": @"Terms and Conditions",
				@"Politica_privacidade": @"Privacy Policy",
				
				//4ª PÁGINA DE REFÚGIO/DEFINIÇÕES/FEEDBACK
				@"Diz_que_pensas": @"Tell us what you think about us",
				@"Classifica_App": @"Rate our App",
				@"Partilha_com_amigos": @"Tell a friend",
				@"Facebook": @"Facebook",
				@"MsgFace": @"I'm using Menu Guru to find special menus of various restaurants. Visit the site and make your own discoveries.",
				@"Email": @"Email",
				@"MsgEmail": @"I'm using Menu Guru to find special menus of various restaurants. Visit the site and make your own discoveries.",
				@"SMS": @"SMS",
				@"MsgSMS": @"I'm using Menu Guru to find special menus of various restaurants. Visit the site and make your own discoveries.",
				//falta a parte do facebook mensagem
				
				//4ª PÁGINA DE REFÚGIO/IDIOMA
				@"Ingles": @"English",
				@"Frances": @"French",
				@"Espanhol": @"Spanish",
				@"Portugues": @"Portuguese",
				@"Italiano": @"Italien",
				@"Alemao": @"German",
				
				//PÁGINA RESTAURANTE Falta Tudo traduzir
				@"Desculpe_restaurante_Sem_Menus_titulo": @"No menus",
				@"Desculpe_restaurante_Sem_Menus_desc": @"There are no menus available in this restaurant. Click here to show your interest.",
				@"Ligar": @"Call",
				@"Marcar": @"Dial",
				@"Sim": @"Yes",
				@"Nao": @"No",
				@"Add_favoritos": @"Add to favorits",
                @"Remover_favoritos": @"Remove from favorits",
				
				//PÁGINA pesquisa não encontrada
				@"Desculpe_pesquisa_titulo": @"Not found",
				@"Desculpe_pesquisa_desc": @"There are no results for your search. Please try different keywords.",

				//Página de Login|Registo
				@"Entre_titulo": @"Log in | Register",
				@"Entre_registar": @"to access the best of Menu Guru.",
				@"Login_facebook": @"Log in with Facebook",
				@"OU": @"Or",
				@"Iniciar_sessao": @"Log in",
				@"Email_invalido": @"Invalid email address",
				@"Email": @"Email",//por em todos
				@"Password": @"Password",//por em todos
				@"Minimo_pass": @"Password must be at least 6 characters.",
				@"Termos_e_condicoes_registar": @"By clicking sign up, you agree to our Menu Guru Terms and that you have read our Privacy Policy.",
				@"Registar_Menu_Guru": @"Sign up for Menu Guru",
				@"Esqueceu_password": @"Forgot password",
				@"Primeiro_Nome": @"First Name",
				@"Ultimo_Nome": @"Last Name",
				@"Homem": @"Men",
				@"Mulher": @"Woman",
				@"Cidade": @"City",
				@"Data_Nascimento": @"Birthday",
				@"Email_LR": @"Email",
				@"Password": @"Password",
				@"Repita_password": @"Repeat password",
				@"Criar_Registo": @"Sign up",
				@"Deve_Preencher_todos_campos.": @"You must complete all fields.",
                @"password_igual": @"The password does not match.",
				
				//popups menus são sempre iguais qualquer seja o cartão que falte
				@"Procurar_menu_clique_mostre_interesse_titulo": @"Show interest",
				@"Procurar_menu_clique_mostre_interesse_descr": @"This restaurant does not provide this information yet. Would you like to show your interest?",
				
				//popups sem net
				@"Erro_de_ligacao": @"Connection error",
				@"Ocorre_erro_internet": @"Please check your internet connection and try again.",
				
				//popups logout
				@"Logout_titulo": @"Warning",
				@"Logout_descricao": @"Do you really want to disconnect?",
				
				//popups nova imagem
				@"Escolha_uma_foto": @"Select a photo",
				@"Galeria": @"Gallery",
				@"Camera": @"Camera",
				@"Cancel_imagem": @"Cancel",
               @"cartao_diaria": @"Daily menu",
               @"cartao_ementa": @"Menu",
               @"cartao_especial": @"Special Menus",
                @"erro": @"Error",
               
               @"menu_dia": @"Daily menu",
               @"menu_especial": @"Menu",
               @"menu_ementa": @"Ementa",
               
               };
    
    
    langES = @{
               //dias da semana
               @"Segunda-feira": @"Lunes",
               @"Terça-feira": @"Martes",
               @"Quarta-feira": @"Miercoles",
               @"Quinta-feira": @"Jueves",
               @"Sexta-feira": @"Viernes",
               @"Sabado": @"Sábado",
               @"Domingo": @"Domingo",
              			   
               //1ª PÁGINA
			    @"Restaurante": @"Restaurante",
                @"Cidade": @"Ciudad",
                @"Pesquisar": @"Buscar",
                @"Meus_menus": @"Mis menus",
                @"Recomendados": @"Sugerencias",
			    @"Favoritos": @"Mis Favoritos",
			    @"Geolocalizacao": @"permitir geolocalización",
			    @"Obter_melhor_Menu_guru": @"para sacar lo mejor de Menú Guru",
				@"Texto_Activa_Geolocalizacao": @"Ir a ajustes, privacidad, servicios de localización y activar este servicio para que podamos determinar su ubicación aproximada y sugerir los menús de los mejores restaurantes alrededor.",
				@"Adicione_Favoritos": @"Añadir Favoritos",
				@"Adicionar_lista_favoritos": @"para sacar lo mejor de Menú Guru",
                 @"Adicionar_lista_fundo": @"Busque por ciudad o nombre del restaurante. Seleccione el restaurante que desea y añádalo a sus favoritos.",
				
				//2ªpagina resultados
				@"Todos": @"Todos",
				
				//1ª PÁGINA DE REFÚGIO
				@"Menu": @"Menu",
				@"Inicio": @"Inicio",
				@"Minha_conta": @"Mi cuenta",
				@"Definicoes": @"Definiciones",
				@"Idioma": @"Idioma",
				
				//2ª PÁGINA DE REFÚGIO/MINHA CONTA
				@"Ola": @"Hola",
				@"Conectado": @"Conectado",
				@"Receber_Notificacoes": @"Recibe Notificaciones",
				@"Conectar_Facebook": @"Conéctate con Facebook",
				@"Receber_Newsletter": @"Recibir Boletín de Noticias",
				@"Mudar_foto": @"Cambiar tu foto",
				
				//3ª PÁGINA DE REFÚGIO/DEFINIÇÕES
				@"Sobre_Menu_Guru": @"Quién es Menu Guru",
				@"Feedback": @"Feedback",
				@"Termos_condicoes": @"Terminos y Condiciones",
				@"Politica_privacidade": @"Politica de Privacidad",
				
				//4ª PÁGINA DE REFÚGIO/DEFINIÇÕES/FEEDBACK
				@"Diz_que_pensas": @"Dinos lo que piensas",
				@"Classifica_App": @"Classifica a App",
				@"Partilha_com_amigos": @"Contar a un amigo",
				@"Facebook": @"Facebook",				
				@"MsgFace": @"Estoy usando a menú gurú para encontrar menús especiales de varios restaurantes. Visita el sitio y haz tus propios descubrimientos.",
				@"Email": @"Email",
				@"MsgEmail": @"Estoy usando a menú gurú para encontrar menús especiales de varios restaurantes. Visita el sitio y haz tus propios descubrimientos.",
				@"SMS": @"SMS",
				@"MsgSMS": @"Estoy usando a menú gurú para encontrar menús especiales de varios restaurantes. Visita el sitio y haz tus propios descubrimientos.",
				//falta a parte do facebook mensagem
				
				//4ª PÁGINA DE REFÚGIO/IDIOMA
				@"Ingles": @"Inglés",
				@"Frances": @"Francés",
				@"Espanhol": @"Español",
				@"Portugues": @"Portugués",
				@"Italiano": @"Italiano",
				@"Alemao": @"Alemán",
				
				//PÁGINA RESTAURANTE Falta Tudo traduzir
				@"Desculpe_restaurante_Sem_Menus_titulo": @"No hay menús",
				@"Desculpe_restaurante_Sem_Menus_desc": @"No hay menús disponibles en este restaurante. Haga clic aquí para mostrar su interés.",
				@"Ligar": @"Llamar",
				@"Marcar": @"Llamar",
				@"Sim": @"Si",
				@"Nao": @"No",
				@"Add_favoritos": @"Añadir a favoritos",
                @"Remover_favoritos": @"Quitar de favoritos",
				
				//PÁGINA pesquisa não encontrada
				@"Desculpe_pesquisa_titulo": @"No se encontró",
				@"Desculpe_pesquisa_desc": @"No hay ningún resultado para su búsqueda. Por favor, busque con palabras clave diferentes.",

				//Página de Login|Registro
				@"Entre_titulo": @"Inicia sesión | Regístrate",
				@"Entre_registar": @"para tener acceso a lo mejor del Menu Guru.",
				@"Login_facebook": @"Conéctate con Facebook",
				@"OU": @"ou",
				@"Iniciar_sessao": @"Inicia sesión",
				@"Email_invalido": @"Dirección de correo electrónico no válida",
				@"Email": @"Email",
				@"Password": @"Password",
				@"Minimo_pass": @"La contraseña debe tener al menos 6 caracteres.",
				@"Termos_e_condicoes_registar": @"Al hacer click en registrate, muestras tu conformidad con nuestras conditiones de Menu Guru y aceptas haber leído nuestra Politica de Privacidad.",
				@"Registar_Menu_Guru": @"Registrate en Menu Guru",
				@"Esqueceu_password": @"Contraseña olvidada?",
				@"Primeiro_Nome": @"Nombre",
				@"Ultimo_Nome": @"Apellidos",
				@"Homem": @"Hombre",
				@"Mulher": @"Mujer",
				@"Cidade": @"Ciudad",
				@"Data_Nascimento": @"Fecha de nacimiento",
				@"Email_LR": @"Correo electronico",
				@"Password": @"Contraseña",
				@"Repita_password": @"Repetir contraseña",
				@"Criar_Registo": @"Registrate",
				@"Deve_Preencher_todos_campos.": @"Debes completar todos los campos.",
                @"password_igual": @"La contraseña no coincide.",
				
				//popups menus são sempre iguais qualquer seja o cartão que falte
				@"Procurar_menu_clique_mostre_interesse_titulo": @"Mostrar interés",
				@"Procurar_menu_clique_mostre_interesse_descr": @"Este restaurante no proporciona esta información. ¿Le gustaría mostrar su interés?",
				
				//popups sem net
				@"Erro_de_ligacao": @"Error de conexión",
				@"Ocorre_erro_internet": @"Por favor, compruebe su conexión a internet e inténtelo de nuevo.",
				
				//popups logout
				@"Logout_titulo": @"Advertencia",
				@"Logout_descricao": @"¿Quieres desconectar?",
				
				//popups nova imagem
				@"Escolha_uma_foto": @"Seleccione una foto",
				@"Galeria": @"Galería",
				@"Camera": @"Cámara",
				@"Cancel_imagem": @"Cancelar",
               @"cartao_diaria": @"Menu del día",
               @"cartao_ementa": @"Menú",
               @"cartao_especial": @"Menús especiales",
               @"erro": @"Error",
				
               @"menu_dia": @"Menu del día",
               @"menu_especial": @"Menús especiales",
               @"menu_ementa": @"Menú",
               
               };
    
    langFR = @{
               //dias da semana
               @"Segunda-feira": @"Lundi",
               @"Terça-feira": @"Mardi",
               @"Quarta-feira": @"Mercredi",
               @"Quinta-feira": @"Juedi",
               @"Sexta-feira": @"Vendredi",
               @"Sabado": @"Samedi",
               @"Domingo": @"Dimanche",
               
               //1ª PÁGINA
			    @"Restaurante": @"Restaurant",
                @"Cidade": @"Ville",
                @"Pesquisar": @"Rechercher",
                @"Meus_menus": @"Mes menus",
                @"Recomendados": @"Suggestions",
			    @"Favoritos": @"Mes favoris",
			    @"Geolocalizacao": @"activer la géolocalisation",
			    @"Obter_melhor_Menu_guru": @"pour obtenir le meilleur de Menu Guru",
				@"Texto_Activa_Geolocalizacao": @"Allez dans paramètres, vie privée, les services de localisation et activer ce service afin que nous puissions déterminer votre position approximative et suggèrent les menus des meilleurs restaurants autour de vous.",
				@"Adicione_Favoritos": @"Ajouter Favoris",
				@"Adicionar_lista_favoritos": @"pour obtenir le meilleur de Menu Guru",
                 @"Adicionar_lista_fundo": @"Recherche par ville ou nom du restaurant. Sélectionnez le restaurant que vous voulez et ajoutez à vos favoris.",
				
				//2ªpagina resultados
				@"Todos": @"Tout",
				
				//1ª PÁGINA DE REFÚGIO
				@"Menu": @"Menu",
				@"Inicio": @"Accueil",
				@"Minha_conta": @"Mon compte",
				@"Definicoes": @"Définitions",
				@"Idioma": @"Langue",
				
				//2ª PÁGINA DE REFÚGIO/MINHA CONTA
				@"Ola": @"Salut",
				@"Conectado": @"Connecté",
				@"Receber_Notificacoes": @"Recevoir des Notifications",
				@"Conectar_Facebook": @"Connectez-vous avec Facebook",
				@"Receber_Newsletter": @"Recevoir la Newsletter",
				@"Mudar_foto": @"Changer votre photo",
				
				//3ª PÁGINA DE REFÚGIO/DEFINIÇÕES
				@"Sobre_Menu_Guru": @"Qui est Menu Guru",
				@"Feedback": @"Feedback",
				@"Termos_condicoes": @"Térmes et Conditions",
				@"Politica_privacidade": @"Politique de Privacité",
				
				//4ª PÁGINA DE REFÚGIO/DEFINIÇÕES/FEEDBACK
				@"Diz_que_pensas": @"Dites-nous ce que vous pensez",
				@"Classifica_App": @"Evaluez la App",
				@"Partilha_com_amigos": @"Parlez-en à un ami",
				@"Facebook": @"Facebook",				
				@"MsgFace": @"J'utilise Menu Guru pour trouver des menus des différents restaurants. Visitez le site et faite vos propres découvertes.",
				@"Email": @"Email",
				@"MsgEmail": @"J'utilise Menu Guru pour trouver des menus des différents restaurants. Visitez le site et faite vos propres découvertes.",
				@"SMS": @"SMS",
				@"MsgSMS": @"J'utilise Menu Guru pour trouver des menus des différents restaurants. Visitez le site et faite vos propres découvertes.",
				//falta a parte do facebook mensagem
				
				//4ª PÁGINA DE REFÚGIO/IDIOMA
				@"Ingles": @"Anglais",
				@"Frances": @"Français",
				@"Espanhol": @"Espagnol",
				@"Portugues": @"Portugais",
				@"Italiano": @"Italien",
				@"Alemao": @"Allemand",
				
				//PÁGINA RESTAURANTE Falta Tudo traduzir
				@"Desculpe_restaurante_Sem_Menus_titulo": @"Pas de menus",
				@"Desculpe_restaurante_Sem_Menus_desc": @"Il n'y a pas de menus disponibles dans ce restaurant. Cliquez ici pour afficher votre intérêt.",
				@"Ligar": @"Appeler",
				@"Marcar": @"Appeler",
				@"Sim": @"Oui",
				@"Nao": @"Nom",
				@"Add_favoritos": @"Ajouter aux favorits",
                @"Remover_favoritos": @"Retirer des favoris",
				
				//PÁGINA pesquisa não encontrada
				@"Desculpe_pesquisa_titulo": @"Non trovato",
				@"Desculpe_pesquisa_desc": @"Votre recherche n'a donné aucun résultat. Veuillez essayer avec des mots clés différents.",

				//Página de Login|Registro
				@"Entre_titulo": @"Connectez-vous | Inscrivez-vous",
				@"Entre_registar": @"pour accéder à la meilleure du Menu Guru.",
				@"Login_facebook": @"Se connecter avec Facebook",
				@"OU": @"ou",
				@"Iniciar_sessao": @"Connexion",
				@"Email_invalido": @"Adresse email invalide",
				@"Email": @"Email",
				@"Password": @"Password",
				@"Minimo_pass": @"Le mot de passe doit être d'au moins 6 caractères.",
				@"Termos_e_condicoes_registar": @"En cliquant sur s'inscrire, vous acceptez nos Conditions d'utilisation du Menu Guru et reconnaissez avoir pris connaissance de notre Politique de Confidentialité.",
				@"Registar_Menu_Guru": @"S'inscrire sur Menu Guru.",
				@"Esqueceu_password": @"Mot de passe oublié?",
				@"Primeiro_Nome": @"Prénom",
				@"Ultimo_Nome": @"Nom de famille",
				@"Homem": @"Homme",
				@"Mulher": @"Femme",
				@"Cidade": @"Ville",
				@"Data_Nascimento": @"Date de naissance",
				@"Email_LR": @"Adresse électronique",
				@"Password": @"Mot de passe",
				@"Repita_password": @"Repeter mot de passe",
				@"Criar_Registo": @"Inscription",
				@"Deve_Preencher_todos_campos.": @"Vous devez compléter tous les champs.",
                @"password_igual": @"Le mot de passe ne correspond pas.",
				
				//popups menus são sempre iguais qualquer seja o cartão que falte
				@"Procurar_menu_clique_mostre_interesse_titulo": @"Montrer l'intérêt",
				@"Procurar_menu_clique_mostre_interesse_descr": @"Ce restaurant ne fournit pas ces informations. Souhaitez-vous montrer votre intérêt?",
				
				//popups sem net
				@"Erro_de_ligacao": @"Erreur de connexion",
				@"Ocorre_erro_internet": @"Veuillez vérifier votre connexion internet et réessayez.",
				
				//popups logout
				@"Logout_titulo": @"Mise en garde",
				@"Logout_descricao": @"Voulez-vous vraiment déconnecter?",
				
				//popups nova imagem
				@"Escolha_uma_foto": @"Sélectionnez une photo",
				@"Galeria": @"Galeria",
				@"Camera": @"Appareil photographique",
				@"Cancel_imagem": @"Annuler",
               @"cartao_diaria": @"Plat du jour",
               @"cartao_ementa": @"Menu",
               @"cartao_especial": @"Menus spéciaux",
                @"erro": @"Erreur",
               
               @"menu_dia": @"Plat du jour",
               @"menu_especial": @"Menus spéciaux",
               @"menu_ementa": @"Menu",
               };

    langIT = @{
               //dias da semana
               @"Segunda-feira": @" Lunedi",
               @"Terça-feira": @" Martedi ",
               @"Quarta-feira": @" Miercoledi ",
               @"Quinta-feira": @" Giovedi ",
               @"Sexta-feira": @" Venerdi ",
               @"Sabado": @" Sabato ",
               @"Domingo": @" Domenica",
               
               //1ª PÁGINA
			    @"Restaurante": @"Ristorante",
                @"Cidade": @"Città",
                @"Pesquisar": @"Ricerca",
                @"Meus_menus": @"I miei menus",
                @"Recomendados": @"Suggerimenti",
			    @"Favoritos": @"I miei preferiti",
			    @"Geolocalizacao": @"consentire geolocalizzazione",
			    @"Obter_melhor_Menu_guru": @"ad avere la meglio di Menu Guru",
				@"Texto_Activa_Geolocalizacao": @"Andare in impostazioni, privacy, servizi di localizzazione e attivare questo servizio in modo che possiamo determinare la vostra posizione approssimativa e suggerire i menù dei migliori ristoranti intorno a te.",
				@"Adicione_Favoritos": @"Aggiungi Preferiti",
				@"Adicionar_lista_favoritos": @"ad avere la meglio di Menu Guru",
                @"Adicionar_lista_fundo": @"Cerchi per città o nome del ristorante. Seleziona il ristorante desiderato e aggiungI ai tuoi preferiti.",
				
				//2ªpagina resultados
				@"Todos": @"Tutti",
				
				//1ª PÁGINA DE REFÚGIO
				@"Menu": @"Menu",
				@"Inicio": @"Home",
				@"Minha_conta": @"Il mio conto",
				@"Definicoes": @"Definizione",
				@"Idioma": @"Lingua",
				
				//2ª PÁGINA DE REFÚGIO/MINHA CONTA
				@"Ola": @"Ciao",
				@"Conectado": @"Collegato",
				@"Receber_Notificacoes": @"Ricevi Notifiche",
				@"Conectar_Facebook": @"Connettiti con Facebook",
				@"Receber_Newsletter": @"Ricevi Newsletter",
				@"Mudar_foto": @"Cambiare la tua foto",
				
				//3ª PÁGINA DE REFÚGIO/DEFINIÇÕES
				@"Sobre_Menu_Guru": @"A proposito di Guru Menu",
				@"Feedback": @"Feedback",
				@"Termos_condicoes": @"Termini e Condizioni",
				@"Politica_privacidade": @"Informativa sulla Privacy",
				
				//4ª PÁGINA DE REFÚGIO/DEFINIÇÕES/FEEDBACK
				@"Diz_que_pensas": @"Dicci cosa ne pensi",
				@"Classifica_App": @"Vota la nostra applicazione",
				@"Partilha_com_amigos": @"Dillo ad un amico",
				@"Facebook": @"Facebook",
				@"MsgFace": @"Sto usando il Menu Guru per trovare menu speciali di vari ristoranti. Visita il sito e fai tu proprie scoperte.",
				@"Email": @"Email",
				@"MsgEmail": @"Sto usando il Menu Guru per trovare menu speciali di vari ristoranti. Visita il sito e fai tu proprie scoperte.",
				@"SMS": @"SMS",
				@"MsgSMS": @"Sto usando il Menu Guru per trovare menu speciali di vari ristoranti. Visita il sito e fai tu proprie scoperte.",
				//falta a parte do facebook mensagem
				
				//4ª PÁGINA DE REFÚGIO/IDIOMA
				@"Ingles": @"Inglese",
				@"Frances": @"Francese",
				@"Espanhol": @"Spagnolo",
				@"Portugues": @"Portoghese",
				@"Italiano": @"Italiano",
				@"Alemao": @"Tedesco",
				
				//PÁGINA RESTAURANTE Falta Tudo traduzir
				@"Desculpe_restaurante_Sem_Menus_titulo": @"Nessun menu",
				@"Desculpe_restaurante_Sem_Menus_desc": @"Nessun menu disponibile in questo ristorante. Fai clic qui per mostrare il vostro interesse.",
				@"Ligar": @"Chiamare",
				@"Marcar": @"Chiamare",
				@"Sim": @"Sì",
				@"Nao": @"No",
				@"Add_favoritos": @"Aggiungere ai favorits",
                @"Remover_favoritos": @"Rimuovere da favorits",
				
				//PÁGINA pesquisa não encontrada
				@"Desculpe_pesquisa_titulo": @"Non trovato",
				@"Desculpe_pesquisa_desc": @"Non ci sono risultati per la ricerca. Prova diverse parole chiave.",

				//Página de Login|Registro
				@"Entre_titulo": @"Accedi | Registrati",
				@"Entre_registar": @"per conoscere il meglio di Menu Guru.",
				@"Login_facebook": @"Connettiti con Facebook",
				@"OU": @"o",
				@"Iniciar_sessao": @"Accedi",
				@"Email_invalido": @"Indirizzo email non valido",
				@"Email": @"Email",
				@"Password": @"Password",
				@"Minimo_pass": @"La password deve essere almeno 6 caratteri.",
				@"Termos_e_condicoes_registar": @"Cliccando su registrati, accetti les nostre termini di Menu Guru e confermi di aver letto la nostra normativa sulla privacy.",
				@"Registar_Menu_Guru": @"Registrati su Menu Guru",
				@"Esqueceu_password": @"Hai dimenticato la password?",
				@"Primeiro_Nome": @"Nome",
				@"Ultimo_Nome": @"Cognome",
				@"Homem": @"Uomo",
				@"Mulher": @"Donna",
				@"Cidade": @"Città",
				@"Data_Nascimento": @"Data de nascita",
				@"Email_LR": @"Email",
				@"Password": @"Password",
				@"Repita_password": @"Ripeti password",
				@"Criar_Registo": @"Registrazione",
				@"Deve_Preencher_todos_campos.": @"È necessario compilare tutti i campi.",
                @"password_igual": @"La password non corrisponde.",
				
				//popups menus são sempre iguais qualquer seja o cartão que falte
				@"Procurar_menu_clique_mostre_interesse_titulo": @"Mostrare interesse",
				@"Procurar_menu_clique_mostre_interesse_descr": @"Questo ristorante non fornisce queste informazioni. Volete mostrare il vostro interesse?",
				
				//popups sem net
				@"Erro_de_ligacao": @"Errore di connessione",
				@"Ocorre_erro_internet": @"Si prega di controllare la connessione a internet e riprovare.",
				
				//popups logout
				@"Logout_titulo": @"Avviso",
				@"Logout_descricao": @"Volete staccare davvero?",
				
				//popups nova imagem
				@"Escolha_uma_foto": @"Seleziona una foto",
				@"Galeria": @"Galerie",
				@"Camera": @"Fotocamera",
				@"Cancel_imagem": @"Annulla",
               @"cartao_diaria": @"Menù del giorno",
               @"cartao_ementa": @"Menu",
               @"cartao_especial": @"Menus speciales",
                 @"erro": @"Errore",
               
               @"menu_dia": @"Menù del giorno",
               @"menu_especial": @"Menus speciales",
               @"menu_ementa": @"Menu",
               
               };
    
 
    langDE = @{
               //dias da semana
               @"Segunda-feira": @" Montag ",
               @"Terça-feira": @" Dienstag ",
               @"Quarta-feira": @" Mittwoch ",
               @"Quinta-feira": @" Donnerstag ",
               @"Sexta-feira": @" Freitag ",
               @"Sabado": @" Samstag ",
               @"Domingo": @" Sonntag ",
               
               //1ª PÁGINA
			    @"Restaurante": @"Restaurant",
                @"Cidade": @"Stadt",
                @"Pesquisar": @"Suche",
                @"Meus_menus": @"Meine menus",
                @"Recomendados": @"Vorschläge",
			    @"Favoritos": @"Meine Favoriten",
			    @"Geolocalizacao": @"Geolocation aktivieren",
			    @"Obter_melhor_Menu_guru": @"um das beste Menü der Guru bekommen",
				@"Texto_Activa_Geolocalizacao": @"Gehen Sie zu Einstellungen, Privatsphäre, Ortungsdienste und aktivieren Sie diesen Dienst zu, so können wir Ihren ungefähren Standort zu bestimmen und schlagen Sie die Menüs der besten Restaurants um dich herum.",
				@"Adicione_Favoritos": @"Favoriten Hinzufügen",
				@"Adicionar_lista_favoritos": @"um das beste Menü der Guru bekommen",
               @"Adicionar_lista_fundo": @"Suche nach Stadt oder Restaurants. Wählen Sie das Restaurant, das Sie wollen und zu Ihren Favoriten hinzufügen.",
				
				//2ªpagina resultados
				@"Todos": @"Alle",
				
				//1ª PÁGINA DE REFÚGIO
				@"Menu": @"Menu",
				@"Inicio": @"Home",
				@"Minha_conta": @"Mein Konto",
				@"Definicoes": @"Definitionen",
				@"Idioma": @"Sprache",
				
				//2ª PÁGINA DE REFÚGIO/MINHA CONTA
				@"Ola": @"Hallo",
				@"Conectado": @"Verbunden",
				@"Receber_Notificacoes": @"Erhalten Sie Benachrichtigungen",
				@"Conectar_Facebook": @"Mit Facebook verbinden",
				@"Receber_Newsletter": @"Erhalten Sie Newsletter",
				@"Mudar_foto": @"Ihr Foto ändern",
				
				//3ª PÁGINA DE REFÚGIO/DEFINIÇÕES
				@"Sobre_Menu_Guru": @"Über Menü-Guru",
				@"Feedback": @"Rückkopplung",
				@"Termos_condicoes": @"Bedingungen und Konditionen",
				@"Politica_privacidade": @"Datenschutz",
				
				//4ª PÁGINA DE REFÚGIO/DEFINIÇÕES/FEEDBACK
				@"Diz_que_pensas": @"Sagen Sie uns, was Sie denken",
				@"Classifica_App": @"Bewerten Sie unsere Anwendung",
				@"Partilha_com_amigos": @"An einen Freund senden",
				@"Facebook": @"Facebook",
				@"MsgFace": @"Ich benutze Menü Guru, um spezielle Menüs der verschiedenen Restaurants zu finden. Besuchen Sie die Website und machen Sie Ihre eigenen Entdeckungen.",
				@"Email": @"Email",
				@"MsgEmail": @"Ich benutze Menü Guru, um spezielle Menüs der verschiedenen Restaurants zu finden. Besuchen Sie die Website und machen Sie Ihre eigenen Entdeckungen.",
				@"SMS": @"SMS",
				@"MsgSMS": @"Ich benutze Menü Guru, um spezielle Menüs der verschiedenen Restaurants zu finden. Besuchen Sie die Website und machen Sie Ihre eigenen Entdeckungen.",
				//falta a parte do facebook mensagem
				
				//4ª PÁGINA DE REFÚGIO/IDIOMA
				@"Ingles": @"Englisch",
				@"Frances": @"Franzosisch",
				@"Espanhol": @"Spanisch",
				@"Portugues": @"Portuguiesisch",
				@"Italiano": @"Italiensch",
				@"Alemao": @"Deutsch",
				
				//PÁGINA RESTAURANTE Falta Tudo traduzir
				@"Desculpe_restaurante_Sem_Menus_titulo": @"Keine Menüs",
				@"Desculpe_restaurante_Sem_Menus_desc": @"Keine der im Menü im restaurant. Klicken Sie hier, um Ihr Interesse zu zeigen.",
				@"Ligar": @"Telefonieren",
				@"Marcar": @"Telefonieren",
				@"Sim": @"Ja",
				@"Nao": @"Nein",
				@"Add_favoritos": @"Zu Favoriten hinzufügen",
                @"Remover_favoritos": @"Aus Favoriten entfernen",
				
				//PÁGINA pesquisa não encontrada
				@"Desculpe_pesquisa_titulo": @"Nicht gefunden",
				@"Desculpe_pesquisa_desc": @"Es gibt keine Ergebnisse für Ihre Suche. Bitte versuchen Sie es mit andere Suchbegriffen.",

				//Página de Login|Registro
				@"Entre_titulo": @"Anmelden | Registrieren",
				@"Entre_registar": @"um das Beste von Menü Guru zu erfahren.",
				@"Login_facebook": @"Mit Facebook verbinden",
				@"OU": @"oder",
				@"Iniciar_sessao": @"Anmelden",
				@"Email_invalido": @"Ungültige E-Mail-Adresse",
				@"Email": @"Email",
				@"Password": @"Password",
				@"Minimo_pass": @"Ihr Passwort muss mindestens 6 Zeichen bestehen.",
				@"Termos_e_condicoes_registar": @"Indem du auf Registrieren klickst, akzeptierst du unsere Allgemeine Geschäftsbedigungen von Menu Guru und die Datenschutzrichtlinien.",
				@"Registar_Menu_Guru": @"Für Menu Guru registrieren",
				@"Esqueceu_password": @"Ihr Passwort vergessen?",
				@"Primeiro_Nome": @"Vorname",
				@"Ultimo_Nome": @"Nachname",
				@"Homem": @"Männlich",
				@"Mulher": @"Weiblich",
				@"Cidade": @"Stadt",
				@"Data_Nascimento": @"Geburstag auswählen",
				@"Email_LR": @"E-mail",
				@"Password": @"Passwort",
				@"Repita_password": @"Passwort wiederholen",
				@"Criar_Registo": @"Registrieren",
				@"Deve_Preencher_todos_campos.": @"Bitte alle Felder ausfüllen.",
                @"password_igual": @"Das Passwort stimmt nicht überein.",
				
				//popups menus são sempre iguais qualquer seja o cartão que falte parte tania no json_m_rest.php
				@"Procurar_menu_clique_mostre_interesse_titulo": @"Zeigen Interesse",
				@"Procurar_menu_clique_mostre_interesse_descr": @"Dieses restaurant bietet diese informationen noch keinen. Möchten Sie Ihr interesse zu zeigen?",
				
				//popups sem net
				@"Erro_de_ligacao": @"Verbindungsfehle",
				@"Ocorre_erro_internet": @"Bitte überprüfen Sie Ihre Internetverbindung und versuchen Sie es erneut.",
				
				//popups logout
				@"Logout_titulo": @"Warnung",
				@"Logout_descricao": @"Wollen Sie wirklich trennen?",
				
				//popups nova imagem
				@"Escolha_uma_foto": @"Wählen Sie ein Foto",
				@"Galeria": @"Galerie",
				@"Camera": @"Fotografische Kamera",
				@"Cancel_imagem": @"Abbrechen",
               @"cartao_diaria": @"Tagesmenü",
               @"cartao_ementa": @"Menü",
               @"cartao_especial": @"Menüs spezial",
               @"erro": @"Fehler",
				
               @"menu_dia": @"Tagesmenü",
               @"menu_especial": @"Menüs Spezial",
               @"menu_ementa": @"Menü",

               
               
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
    } else if ([[Globals lang] isEqualToString:@"it"]){
        return [langIT objectForKey:index];
    }else if ([[Globals lang] isEqualToString:@"de"]){
        return [langDE objectForKey:index];
    }else
        return [langPT objectForKey:index];


    
}

@end
