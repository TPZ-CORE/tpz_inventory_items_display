let itemDisplay = null;

document.addEventListener("DOMContentLoaded", function () {

  itemDisplay = document.getElementById("tpz-item-display");

});


window.addEventListener("message", function (event) {

  const data = event.data;

  if (!data || !data.action) {
    return;
  }

  // =========================================================
  // DISPLAY ITEM
  // =========================================================

  if (data.action === "displayItem") {

    if (!itemDisplay) {
      itemDisplay = document.getElementById("tpz-item-display");
    }

    if (!itemDisplay) {
      return;
    }

    const item = data.item || "";
    const label = data.label || "";
    const quantity = Number(data.quantity) || 0;
    const type = data.type || "add";

    // -----------------------------------------------------
    // TYPE
    // -----------------------------------------------------

    const isAdded = type === "add";

    // -----------------------------------------------------
    // ADD / REMOVE CLASS
    // -----------------------------------------------------

    itemDisplay.classList.remove("add");
    itemDisplay.classList.remove("remove");

    itemDisplay.classList.add(isAdded ? "add" : "remove");

    // -----------------------------------------------------
    // IMAGE
    // -----------------------------------------------------

    const image =
      itemDisplay.querySelector(".item-display-image");

    if (image) {

      const imagePath =
        "nui://tpz_inventory/html/img/items/" + item + ".png";

      image.src = imagePath;

      image.style.display = "block";

      image.onerror = function () {

        this.style.display = "none";

      };

    }

    // -----------------------------------------------------
    // LABEL
    // -----------------------------------------------------

    const labelElement =
      itemDisplay.querySelector(".item-display-label");

    if (labelElement) {

      labelElement.textContent = label;

    }

    // -----------------------------------------------------
    // QUANTITY
    // -----------------------------------------------------

    const quantityElement =
      itemDisplay.querySelector(".item-display-quantity");

    if (quantityElement) {

      quantityElement.textContent =
        (isAdded ? "+" : "-") + quantity;

    }

    // -----------------------------------------------------
    // TYPE TEXT
    // -----------------------------------------------------

    const typeElement =
      itemDisplay.querySelector(".item-display-type");

    if (typeElement) {

      typeElement.textContent =
        isAdded ? "RECEIVED" : "REMOVED";

    }

    // -----------------------------------------------------
    // SHOW
    // -----------------------------------------------------

    itemDisplay.classList.add("active");

  }


  // =========================================================
  // CLOSE ITEM
  // =========================================================

  if (data.action === "closeItem") {

    if (!itemDisplay) {
      itemDisplay = document.getElementById("tpz-item-display");
    }

    if (!itemDisplay) {
      return;
    }

    itemDisplay.classList.remove("active");

  }

});