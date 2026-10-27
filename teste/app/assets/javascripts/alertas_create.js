
var mensagens_create = {
    erro_create: {
        title: "Erro ao criar",
        // text: "Erro ao criar",
        icon: "error"
    },
    sucesso_create: {
        title: "Criado com sucesso",
        icon: "success"
    },
    deletar_sucesso: {
        title: "Excluído com sucesso",
        icon: "success"
    }
};

function alerta(chave) {
    if(!chave || !mensagens_create[chave]) {
        return;
    }
    return Swal.fire(mensagens_create[chave]);
}

$(function() {
    var chave = $("#alerta").attr("data-chave");
    
    if(chave) {
        alerta(chave);
    }
});
