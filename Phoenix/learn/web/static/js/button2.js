let Button = {
    init(socket, element) {
        if (!element) { return }
        socket.connect()
        this.onReady("buttons2", socket)
    },
    onReady(buttonId, socket) {
        let div_menu = document.getElementById("div_menu")
        let div_buttons2 = document.getElementById("div_buttons2")
        let buttonChannel = socket.channel("buttons2:" + buttonId)

        function outerHTML(node) {
            return node.outerHTML || new XMLSerializer().serializeToString(node);
        }

        buttonChannel.join()
            .receive("ok", resp => {
                console.log("Iniciando Buttons2 Channel", resp)
                let divs = {
                    div_button: outerHTML(div_buttons2),
                    div_menu: outerHTML(div_menu)
                }
                buttonChannel.push("new_load", divs)
                    .receive("error", e => console.log(e))

                buttonChannel.on("new_load", (resp) => {
                    this.renderDiv_buttons2(resp)
                })

            })
            .receive("error", reason => console.log("Falha", reason))
    },
    renderDiv_buttons2({ div_str_button, div_str_menu }) {
        let div_buttons2 = document.getElementById("div_buttons2")
        let div_menu = document.getElementById("div_menu")

        if (div_buttons2) {
            div_buttons2.innerHTML = div_str_button
            div_menu.innerHTML = div_str_menu
        }
    }
}

export default Button