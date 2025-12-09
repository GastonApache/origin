// JS reçoit de Lua
window.addEventListener('message', (event) => {
    if (event.data.type === "openMenu") {
        document.getElementById('menu').style.display = 'block';
    }
});

// JS envoie à Lua
fetch(`https://${GetParentResourceName()}/buttonClicked`, {
    method: 'POST',
    body: JSON.stringify({button: "play"})
});