let Button = {
    init(socket, element) {
        if (!element) { return }
        socket.connect()
        this.onReady("buttons2", socket)
    },
    onReady(buttonId, socket) {
        let div_vazia = document.getElementById("div_vazia")
        let div_buttons2 = document.getElementById("div_buttons2")
        let buttonChannel = socket.channel("buttons2:" + buttonId)

        div_buttons2.addEventListener("click", e => {
            let params = {params: params} 
        }

    )

        buttonChannel.join()
            .receive("ok", resp => console.log("Iniciando Buttons2 Channel", resp))
            .receive("error", reason => console.log("Falha", reason))
    }
}

export default Button