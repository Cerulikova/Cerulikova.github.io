class MyHeader extends HTMLElement{
	connectedCallback(){
		this.innerHTML =`
		<header>
			<h1>Bakalárska práca</h1>
			<h2>Počítačová hra The Hopper</h2>
			<nav>
				<a class="navlink" href="index.html">Domov</a>
				<a class="navlink" href="diary.html">Denník</a>
				<a class="navlink" href="work.html">Práca</a>
				<a class="navlink" href="bestiary.html">Beštiár</a>
				<a class="navlink" href="resources.html">Zdroje</a>
			</nav>
		</header>`
	}	
}

class MyFooter extends HTMLElement{
	connectedCallback(){
		this.innerHTML = `
		<footer>
			Vytvorila <strong>Mária Cerulíková</strong> v rámci predmetu Bakalársky seminár.<br>
			<strong>Mail:</strong> cerulikova2@uniba.sk<br>
			<strong>Posledne aktualizované:</strong> 24.3.2025<br>
			Obrázok na pozadí od <a href="https://pixabay.com/sk/users/aronvisuals-10427643/?utm_source=link-attribution&utm_medium=referral&utm_campaign=image&utm_content=8433585">Aron Visuals</a> z <a href="https://pixabay.com/sk//?utm_source=link-attribution&utm_medium=referral&utm_campaign=image&utm_content=8433585">Pixabay</a>
			
		</footer>`
	}
}

customElements.define('my-header', MyHeader)
customElements.define('my-footer', MyFooter)