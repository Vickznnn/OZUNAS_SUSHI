const filterButtons = document.querySelectorAll("[data-filter]");
const menuCards = document.querySelectorAll(".menu-card");
const toast = document.getElementById("toast");

filterButtons.forEach((button) => {
    button.addEventListener("click", () => {
        const category = button.dataset.filter;

        filterButtons.forEach((item) => item.classList.remove("active"));
        button.classList.add("active");

        menuCards.forEach((card) => {
            const shouldShow = category === "todos" || card.dataset.category === category;
            card.style.display = shouldShow ? "" : "none";
        });
    });
});

document.querySelectorAll("[data-item]").forEach((button) => {
    button.addEventListener("click", () => {
        showToast(`${button.dataset.item} foi adicionado ao pedido.`);
    });
});

document.querySelectorAll("[data-toggle-password]").forEach((button) => {
    button.addEventListener("click", () => {
        const input = document.getElementById(button.dataset.togglePassword);

        if (!input) {
            return;
        }

        input.type = input.type === "password" ? "text" : "password";
        button.setAttribute("aria-label", input.type === "password" ? "Mostrar senha" : "Ocultar senha");
    });
});

function showToast(message) {
    if (!toast) {
        return;
    }

    toast.textContent = message;
    toast.classList.add("show");

    window.clearTimeout(showToast.timeoutId);
    showToast.timeoutId = window.setTimeout(() => {
        toast.classList.remove("show");
    }, 2600);
}
