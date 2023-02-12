struct DefaultAboutUs: AboutUs {
    
    func getAboutUsDescription(onComplete: (String) -> Void) {
        
        let defaultDescription = """
A DevServices é o melhor aplicativo para reservar seu agendamento com serviços. Aqui é um espaço que você consegue reservar um espaço na minha agenda e vamos resolver suas dúvidas.\nSelecione o tipo de atendimento e vamos pra cima!

*Ilustrativo
"""
        
        onComplete(defaultDescription)
    }
}
