
var mensagens = {
    credenciais_erradas: {
        title: "Erro no login",
        msg: "Email ou senha inválidos",
        tipo: "error"
    },
    saiu: {
        title: "Até logo",
        msg: "Você saiu",
        tipo: "info"
    }
};

function alert_login(event, chave) {
    event.preventDefault();
    var form = event.target.form;

    var dados = mensagens[chave];
    if (!dados) {
        return false;
    }

    Swal.fire({
        title: dados.title,
        text: dados.msg,
        icon: dados.tipo,
        confirmButtonText: "OK"
    }).then(function (resultado) {
        if (resultado.isConfirmed) {
            form.submit();
        }
    });

    return false;
}
