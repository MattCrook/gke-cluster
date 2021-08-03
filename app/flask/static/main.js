const init = () => {
  animateInput();
  submitForm();
};

init();


function animateInput() {
  const inputNodes = document.querySelectorAll(".input");
  const allInputs = Array.from(inputNodes);
  allInputs.forEach((input) => {
    console.log("here");
    input.addEventListener("click", (e) => {
      console.log("here");

      if (e.target.value === "") {
        input.classList.remove("filled");
      } else {
        input.classList.add("filled");
      }
    });
  });
}

function submitForm() {
  const submit = document.getElementById("submit");

  submit.addEventListener("click", (e) => {
    e.preventDefault();
    const name = document.getElementById("name");
    const username = document.getElementById("username");
    const favoriteTech = document.getElementById("favorite_tech");
    const description = document.getElementById("description");

    const payload = {
      name: name.value,
      username: username.value,
      favoriteTech: favoriteTech.value,
      description: description.value
    };

      sendFormData(payload).then((response) => {
          window.alert("Submitted!");
          document.getElementById("main").style.display = "block";
          window.location.href = window.location.origin
      })
      .catch(err => console.log({err}))
  });
}

async function sendFormData(payload) {
  const origin = window.location.origin;
  try {
    const resp = await fetch(`${origin}/api/users`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      Accept: "application/json",
      body: JSON.stringify(payload)
    });
    return await resp.json();
  } catch (err) {
    console.log(err);
  }
}
