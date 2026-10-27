
var mensagens = {
    credenciais_erradas: {
        title: "Erro no login",
        text: "Email ou senha inválidos",
        icon: "error"
    },
    saiu: {
        title: "Até logo",
        icon: "info"
    },
    login_sucesso: {
        title: "Login ok",
        text: "Usuário logado com sucesso",
        icon: "info"
    }
};

function alert_login(event, chave) {
    if(!chave || !mensagens[chave]) {
        return true;
    }

    event.preventDefault();
    var form = event.target.form;

    Swal.fire(mensagens[chave]).then(function (resultado) {
        if (resultado.isConfirmed) {
            form.submit();
        }
    });

    return false;
}

document.addEventListener("DOMContentLoaded", function () {
    var elemento = document.getElementById("alerta");
    var chave = elemento && elemento.getAttribute("data-chave");

    if (chave && mensagens[chave]) {
        Swal.fire(mensagens[chave]);
    }
});

// function alert_login(event, chave) {
//     event.preventDefault();
//     var form = event.target.form;

//     var dados = mensagens[chave];
//     if (!dados || !chave) {
//         return false;
//     }

//     Swal.fire({
//         title: dados.title,
//         text: dados.msg,
//         icon: dados.tipo,
//         confirmButtonText: "OK"
//     }).then(function (resultado) {
//         if (resultado.isConfirmed) {
//             form.submit();
//         }
//     });

//     return false;
// }
