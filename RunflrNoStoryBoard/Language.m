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
               //2ª PÁGINA
               @"Resultados": @"Results",
               //1ª PÁGINA DE REFÚGIO
               @"A_minha_conta": @"My account",
               @"Definicoes": @"Settings",
               @"Idioma": @"Language",
               //2ª PÁGINA DE REFÚGIO/MINHA CONTA
               //3ª PÁGINA DE REFÚGIO/DEFINIÇÕES
               @"Sobre_Menu_Guru": @"About Menu Guru",
               @"Feedback": @"Feedback",
               @"Termos_condicoes": @"Terms and conditions",
               @"Politica_privacidade": @"Privacy policy",
               //4ª PÁGINA DE REFÚGIO/DEFINIÇÕES/FEEDBACK
               @"Diz_pensas": @"Tell us what you think about us",
               @"Classifica_App": @"Rate our App",
               @"Partilha_amigos ": @"Tell a friend",
               @"Facebook": @"Facebook",
               @"Email": @"Email",
               @"SMS": @"SMS",
               //4ª PÁGINA DE REFÚGIO/IDIOMA
               @"Ingles ": @"English",
               @"Frances": @"French",
               @"Espanhol ": @"Spanish",
               @"Portugues": @"Portuguese",
               @"Italiano": @"Italien",
               @"Alemao": @"German",
               //PÁGINA RESTAURANTE
               @"Hoje": @"Today",
               @"Menu": @"Menu",
               //FRASES POP UP
               //SEPARADORES EMENTAS//não recebi
               @" Entradas": @" Entradas ",
               @" Sopas": @" Sopas",
               @" Saladas": @" Saladas",
               @" Carne ": @" Carne ",
               @" Peixe ": @" Peixe ",
               @" Snacks ": @" Snacks ",
               @" Pastas": @" Pastas",
               @" Pizzas ": @" Pizzas ",
               @" Mariscos ": @" Mariscos ",
               @" Risottos ": @" Risottos ",
               @" Sobremesas ": @" Sobremesas ",
               @" Gelados ": @" Gelados ",
               @" Petiscos ": @" Petiscos ",
               @" Queijos ": @" Queijos ",
               @" Frutas": @" Frutas ",
               @" Vinhos ": @" Vinhos ",
               @" Bebidas ": @" Bebidas ", //não recebi
               //menu especial
               @" Menu_especial_MN_DN ": @" Menu especial???? Menu de Natal / Dia dos Namorados ",//não recebi
               // FRASES
               @" Adicina_restaurantes_favoritos": @" Adicina aqui os teus restaurantes favoritos! ",//não recebi
               @" Restaurante_nao_mostra_Menu_dia ": @" This restaurant don't give this information right now.",
               @" Clica_ficares_par_dessa_novidade": @" Click here to show them your interest about this.",
               @" Restaurante_ainda_nao_mostra_Ementa ": @" Este restaurante ainda não te mostra a Ementa? ",//não recebi
               @" Ups_menu_dia_ainda_nao_esta_disponivel": @" Ups! O menu do dia ainda não está disponível. ",//não recebi
               
               };
    
    
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
               @"Cidade": @" Cidade",
               @"Pesquisar": @" Pesquisar ",
               @"Meus_menus": @" Meus menus ",
               //2ª PÁGINA
               @"Resultados": @" Resultados ",
               //1ª PÁGINA DE REFÚGIO
               @"A_minha_conta": @" A minha conta ",
               @"Definicoes": @" Definições ",
               @"Idioma": @" Idioma ",
               //2ª PÁGINA DE REFÚGIO/MINHA CONTA
               //3ª PÁGINA DE REFÚGIO/DEFINIÇÕES
               @"Sobre_Menu_Guru": @" Sobre o Menu Guru ",
               @"Feedback": @"Feedback",
               @"Termos_condicoes": @" Termos e condições ",
               @"Politica_privacidade": @" Política de privacidade ",
               //4ª PÁGINA DE REFÚGIO/DEFINIÇÕES/FEEDBACK
               @"Diz_pensas": @" Diz-nos o que pensas ",
               @"Classifica_App": @" Classifica a App ",
               @"Partilha_amigos ": @" Partilha com os amigos ",
               @"Facebook": @"Facebook",
               @"Email": @"Email",
               @"SMS": @"SMS",
               //4ª PÁGINA DE REFÚGIO/IDIOMA
               @"Ingles ": @" Inglês ",
               @"Frances": @" Francês ",
               @"Espanhol ": @" Espanhol ",
               @"Portugues": @" Português ",
               @"Italiano": @" Italiano",
               @"Alemao": @" Alemão",
               //PÁGINA RESTAURANTE
               @"Hoje": @" Hoje ",
               @"Menu": @"Menu",
               //FRASES POP UP
               //SEPARADORES EMENTAS
               @" Entradas": @" Entradas ",
               @" Sopas": @" Sopas",
               @" Saladas": @" Saladas",
               @" Carne ": @" Carne ",
               @" Peixe ": @" Peixe ",
               @" Snacks ": @" Snacks ",
               @" Pastas": @" Pastas",
               @" Pizzas ": @" Pizzas ",
               @" Mariscos ": @" Mariscos ",
               @" Risottos ": @" Risottos ",
               @" Sobremesas ": @" Sobremesas ",
               @" Gelados ": @" Gelados ",
               @" Petiscos ": @" Petiscos ",
               @" Queijos ": @" Queijos ",
               @" Frutas": @" Frutas ",
               @" Vinhos ": @" Vinhos ",
               @" Bebidas ": @" Bebidas ",
               //menu especial
               @" Menu_especial_MN_DN ": @" Menu especial???? Menu de Natal / Dia dos Namorados ",
               // FRASES
               @" Adicina_restaurantes_favoritos": @" Adicina aqui os teus restaurantes favoritos! ",
               @" Restaurante_nao_mostra_Menu_dia ": @" Este restaurante ainda não te mostra o Menu do dia? ",
               @" Clica_ficares_par_dessa_novidade": @" Clica aqui para ficares a par dessa novidade. ",
               @" Restaurante_ainda_nao_mostra_Ementa ": @" Este restaurante ainda não te mostra a Ementa? ",
               @" Ups_menu_dia_ainda_nao_esta_disponivel": @" Ups! O menu do dia ainda não está disponível. ",
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
               @"Cidade": @" Ciudad",
               @"Pesquisar": @" Encontrar",
               @"Meus_menus": @" Mis menus",
               //2ª PÁGINA
               @"Resultados": @" Resultados ",
               //1ª PÁGINA DE REFÚGIO
               @"A_minha_conta": @" Mi cuenta ",
               @"Definicoes": @" Definiciones",
               @"Idioma": @" Idioma ",
               //2ª PÁGINA DE REFÚGIO/MINHA CONTA
               //3ª PÁGINA DE REFÚGIO/DEFINIÇÕES
               @"Sobre_Menu_Guru": @" Quién es Menu Guru",
               @"Feedback": @"Feedback",
               @"Termos_condicoes": @" Terminos y condiciones",
               @"Politica_privacidade": @" Politica de privacidad",
               //4ª PÁGINA DE REFÚGIO/DEFINIÇÕES/FEEDBACK
               @"Diz_pensas": @" Dinos lo que piensas",
               @"Classifica_App": @" Valora la App",
               @"Partilha_amigos ": @"Contar a un amigo",
               @"Facebook": @"Facebook",
               @"Email": @"Email",
               @"SMS": @"SMS",
               //4ª PÁGINA DE REFÚGIO/IDIOMA
               @"Ingles ": @" Inglés ",
               @"Frances": @" Francés ",
               @"Espanhol ": @" Español",
               @"Portugues": @" Portugués ",
               @"Italiano": @" Italiano",
               @"Alemao": @" Alemán",
               //PÁGINA RESTAURANTE
               @"Hoje": @" Hoy",
               @"Menu": @"Menu",
               //FRASES POP UP
               //SEPARADORES EMENTAS//não recebi
               @" Entradas": @" Entradas ",
               @" Sopas": @" Sopas",
               @" Saladas": @" Saladas",
               @" Carne ": @" Carne ",
               @" Peixe ": @" Peixe ",
               @" Snacks ": @" Snacks ",
               @" Pastas": @" Pastas",
               @" Pizzas ": @" Pizzas ",
               @" Mariscos ": @" Mariscos ",
               @" Risottos ": @" Risottos ",
               @" Sobremesas ": @" Sobremesas ",
               @" Gelados ": @" Gelados ",
               @" Petiscos ": @" Petiscos ",
               @" Queijos ": @" Queijos ",
               @" Frutas": @" Frutas ",
               @" Vinhos ": @" Vinhos ",
               @" Bebidas ": @" Bebidas ", //não recebi
               //menu especial
               @" Menu_especial_MN_DN ": @" Menu especial???? Menu de Natal / Dia dos Namorados ",//não recebi
               // FRASES
               @" Adicina_restaurantes_favoritos": @" Adicina aqui os teus restaurantes favoritos! ",//não recebi
               @" Restaurante_nao_mostra_Menu_dia ": @" Este restaurante todavia no proporciona esta información.",
               @" Clica_ficares_par_dessa_novidade": @" Haz clic y muéstrale tu interés.",
               @" Restaurante_ainda_nao_mostra_Ementa ": @" Este restaurante ainda não te mostra a Ementa? ",//não recebi
               @" Ups_menu_dia_ainda_nao_esta_disponivel": @" Ups! O menu do dia ainda não está disponível. ",//não recebi
               
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
               @"Pesquisar": @" Rechercher",
               @"Meus_menus": @"Mes menus",
               //2ª PÁGINA
               @"Resultados": @"Résultats",
               //1ª PÁGINA DE REFÚGIO
               @"A_minha_conta": @"Mon compte",
               @"Definicoes": @" Définitions",
               @"Idioma": @" Langue",
               //2ª PÁGINA DE REFÚGIO/MINHA CONTA
               //3ª PÁGINA DE REFÚGIO/DEFINIÇÕES
               @"Sobre_Menu_Guru": @" Qui est Menu Guru",
               @"Feedback": @"Feedback",
               @"Termos_condicoes": @"Térmes et conditions ",
               @"Politica_privacidade": @" Politique de privacité",
               //4ª PÁGINA DE REFÚGIO/DEFINIÇÕES/FEEDBACK
               @"Diz_pensas": @" Dites-nous ce que vous pensez",
               @"Classifica_App": @" Evaluez la App",
               @"Partilha_amigos ": @"Parlez-en à un ami",
               @"Facebook": @"Facebook",
               @"Email": @"Email",
               @"SMS": @"SMS",
               //4ª PÁGINA DE REFÚGIO/IDIOMA
               @"Ingles ": @" Anglais ",
               @"Frances": @" Français ",
               @"Espanhol ": @" Espagnol ",
               @"Portugues": @" Portugais ",
               @"Italiano": @" Italien ",
               @"Alemao": @" Allemand ",
               //PÁGINA RESTAURANTE
               @"Hoje": @" Aujourd'hui",
               @"Menu": @"Menu",
               //FRASES POP UP
               //SEPARADORES EMENTAS//não recebi
               @" Entradas": @" Entradas ",
               @" Sopas": @" Sopas",
               @" Saladas": @" Saladas",
               @" Carne ": @" Carne ",
               @" Peixe ": @" Peixe ",
               @" Snacks ": @" Snacks ",
               @" Pastas": @" Pastas",
               @" Pizzas ": @" Pizzas ",
               @" Mariscos ": @" Mariscos ",
               @" Risottos ": @" Risottos ",
               @" Sobremesas ": @" Sobremesas ",
               @" Gelados ": @" Gelados ",
               @" Petiscos ": @" Petiscos ",
               @" Queijos ": @" Queijos ",
               @" Frutas": @" Frutas ",
               @" Vinhos ": @" Vinhos ",
               @" Bebidas ": @" Bebidas ", //não recebi
               //menu especial
               @" Menu_especial_MN_DN ": @" Menu especial???? Menu de Natal / Dia dos Namorados ",//não recebi
               // FRASES
               @" Adicina_restaurantes_favoritos": @" Adicina aqui os teus restaurantes favoritos! ",//não recebi
               @" Restaurante_nao_mostra_Menu_dia ": @" Ce restaurant ne fournit pas encore cette information.",
               @" Clica_ficares_par_dessa_novidade": @" Montrez votre intérêt.",
               @" Restaurante_ainda_nao_mostra_Ementa ": @" Este restaurante ainda não te mostra a Ementa? ",//não recebi
               @" Ups_menu_dia_ainda_nao_esta_disponivel": @" Ups! O menu do dia ainda não está disponível. ",//não recebi
               
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
               @"Restaurante": @" Ristorante ",
               @"Cidade": @" Città ",
               @"Pesquisar": @" Ricerca ",
               @"Meus_menus": @" I miei menus ",
               //2ª PÁGINA
               @"Resultados": @" Risultati",
               //1ª PÁGINA DE REFÚGIO
               @"A_minha_conta": @" Il mio conto ",
               @"Definicoes": @" Definizione ",
               @"Idioma": @" Lingua ",
               //2ª PÁGINA DE REFÚGIO/MINHA CONTA
               //3ª PÁGINA DE REFÚGIO/DEFINIÇÕES
               @"Sobre_Menu_Guru": @" A proposito di Guru Menu",
               @"Feedback": @"Feedback",
               @"Termos_condicoes": @" Termini e condizioni",
               @"Politica_privacidade": @" Informativa sulla privacy",
               //4ª PÁGINA DE REFÚGIO/DEFINIÇÕES/FEEDBACK
               @"Diz_pensas": @" Dicci cosa ne pensi",
               @"Classifica_App": @" Vota la nostra applicazione",
               @"Partilha_amigos ": @" Dillo ad un amico",
               @"Facebook": @"Facebook",
               @"Email": @"Email",
               @"SMS": @"SMS",
               //4ª PÁGINA DE REFÚGIO/IDIOMA
               @"Ingles ": @" Inglese ",
               @"Frances": @" Francese ",
               @"Espanhol ": @" Spagnolo ",
               @"Portugues": @" Portoghese ",
               @"Italiano": @" Italiano ",
               @"Alemao": @" Tedesco ",
               //PÁGINA RESTAURANTE
               @"Hoje": @" Oggi",
               @"Menu": @"Menu",
               //FRASES POP UP
               //SEPARADORES EMENTAS
               @" Entradas": @" Entradas ",//não recebi
               @" Sopas": @" Sopas",//não recebi
               @" Saladas": @" Saladas",//não recebi
               @" Carne ": @" Carne ",//não recebi
               @" Peixe ": @" Peixe ",//não recebi
               @" Snacks ": @" Snacks ",//não recebi
               @" Pastas": @" Pastas",//não recebi
               @" Pizzas ": @" Pizzas ",//não recebi
               @" Mariscos ": @" Mariscos ",//não recebi
               @" Risottos ": @" Risottos ",//não recebi
               @" Sobremesas ": @" Sobremesas ",//não recebi
               @" Gelados ": @" Gelados ",//não recebi
               @" Petiscos ": @" Petiscos ",//não recebi
               @" Queijos ": @" Queijos ",//não recebi
               @" Frutas": @" Frutas ",//não recebi
               @" Vinhos ": @" Vinhos ",//não recebi
               @" Bebidas ": @" Bebidas ", //não recebi
               //menu especial
               @" Menu_especial_MN_DN ": @" Menu especial???? Menu de Natal / Dia dos Namorados ",//não recebi
               // FRASES
               @" Adicina_restaurantes_favoritos": @" Adicina aqui os teus restaurantes favoritos! ",//não recebi
               @" Restaurante_nao_mostra_Menu_dia ": @" Este restaurante ainda não te mostra o Menu do dia? ", //não recebi
               @" Clica_ficares_par_dessa_novidade": @" Clica aqui para ficares a par dessa novidade. ",//não recebi
               @" Restaurante_ainda_nao_mostra_Ementa ": @" Este restaurante ainda não te mostra a Ementa? ",//não recebi
               @" Ups_menu_dia_ainda_nao_esta_disponivel": @" Ups! O menu do dia ainda não está disponível. ",//não recebi
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
               @"Restaurante": @" Restaurant ",
               @"Cidade": @" Stadt ",
               @"Pesquisar": @" Suche ",
               @"Meus_menus": @" Meine menus ",
               //2ª PÁGINA
               @"Resultados": @" Ergebnisse",
               //1ª PÁGINA DE REFÚGIO
               @"A_minha_conta": @"Mein Konto ",
               @"Definicoes": @" Definitionen ",
               @"Idioma": @" Sprache ",
               //2ª PÁGINA DE REFÚGIO/MINHA CONTA
               //3ª PÁGINA DE REFÚGIO/DEFINIÇÕES
               @"Sobre_Menu_Guru": @" Über Menü-Guru",
               @"Feedback": @"Feedback",
               @"Termos_condicoes": @" Bedingungen und Konditionen",
               @"Politica_privacidade": @" Datenschutz ",
               //4ª PÁGINA DE REFÚGIO/DEFINIÇÕES/FEEDBACK
               @"Diz_pensas": @" Sagen Sie uns, was Sie denken",
               @"Classifica_App": @" Bewerten Sie unsere Anwendung",
               @"Partilha_amigos ": @" An einen Freund senden ",
               @"Facebook": @"Facebook",
               @"Email": @"Email",
               @"SMS": @"SMS",
               //4ª PÁGINA DE REFÚGIO/IDIOMA
               @"Ingles ": @" Englisch ",
               @"Frances": @" Franzosisch ",
               @"Espanhol ": @" Spanisch ",
               @"Portugues": @" Portuguiesisch ",
               @"Italiano": @" Italiensch ",
               @"Alemao": @" Deutsch ",
               //PÁGINA RESTAURANTE
               @"Hoje": @" Heute",
               @"Menu": @"Menü",
               //FRASES POP UP
               //SEPARADORES EMENTAS
               @" Entradas": @" Entradas ",//não recebi
               @" Sopas": @" Sopas",//não recebi
               @" Saladas": @" Saladas",//não recebi
               @" Carne ": @" Carne ",//não recebi
               @" Peixe ": @" Peixe ",//não recebi
               @" Snacks ": @" Snacks ",//não recebi
               @" Pastas": @" Pastas",//não recebi
               @" Pizzas ": @" Pizzas ",//não recebi
               @" Mariscos ": @" Mariscos ",//não recebi
               @" Risottos ": @" Risottos ",//não recebi
               @" Sobremesas ": @" Sobremesas ",//não recebi
               @" Gelados ": @" Gelados ",//não recebi
               @" Petiscos ": @" Petiscos ",//não recebi
               @" Queijos ": @" Queijos ",//não recebi
               @" Frutas": @" Frutas ",//não recebi
               @" Vinhos ": @" Vinhos ",//não recebi
               @" Bebidas ": @" Bebidas ", //não recebi
               //menu especial
               @" Menu_especial_MN_DN ": @" Menu especial???? Menu de Natal / Dia dos Namorados ",//não recebi
               // FRASES
               @" Adicina_restaurantes_favoritos": @" Adicina aqui os teus restaurantes favoritos! ",//não recebi
               @" Restaurante_nao_mostra_Menu_dia ": @" Este restaurante ainda não te mostra o Menu do dia? ", //não recebi
               @" Clica_ficares_par_dessa_novidade": @" Clica aqui para ficares a par dessa novidade. ",//não recebi
               @" Restaurante_ainda_nao_mostra_Ementa ": @" Este restaurante ainda não te mostra a Ementa? ",//não recebi
               @" Ups_menu_dia_ainda_nao_esta_disponivel": @" Ups! O menu do dia ainda não está disponível. ",//não recebi
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
