const app = document.getElementById('app');
const titleEl = document.getElementById('menu-title');
const subTitleEl = document.getElementById('menu-subtitle');
const descBox = document.getElementById('description-box');
const descText = document.getElementById('desc-text');

window.addEventListener('message',
	function(event) {
		let data = event.data;
		if (data.action === "setVisible"){
			app.style.display = data.show ? "block" : "none";
		}

		if (data.action === "updateMenu") {
			//mettre a jour les textestitlEl.innertext = data.file;subTilteEL.innerText = data.subtitle;
			//generer les boutons itemsContainer.innerHTML='';
			//on nettoie

		data.items.forEach((item,index) => {
			let div = document.createElement('div');
			//si l index corespond a la selection lua on ajoutye la classe active
			div.className = (index + 1 === data.currentSelect) ? 'item active' : 'item';
			//contenu html du bouton 
			let rightLabel = item.rightLabel ? `<span class="right-label">${item.rightLabel}</span>` : '';
			div.innerHTML = `<span>${item.label}</span>${rightLabel}`;
			itemsContainer.appendChild(div);
		});

		let activeItemData = data.items[data.currentSelect-1];
		if (activeItemData && activeItemData.description) {
			descBox.style.display="block";
			descText.innerText = activeItemData.description;
		} else {
			descBox.style.display = "none";
		}
	}
});
