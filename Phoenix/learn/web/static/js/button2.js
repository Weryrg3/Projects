let Button = {
    init(socket, element) {
        if (!element) { return }
        socket.connect()
        this.onReady("buttons2", socket)
    },
    onReady(buttonId, socket) {
        let buttonChannel = socket.channel("buttons2:" + buttonId)
        buttonChannel.join()
            .receive("ok", resp => console.log("Buttons unido ao Channel", resp))
            .receive("error", reason => console.log("Falha", reason))
    }
}

export default Button