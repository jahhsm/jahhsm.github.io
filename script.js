document.addEventListener("DOMContentLoaded", () => {
    const searchInput = document.getElementById("search");
    const fileContainer = document.getElementById("file-container");
    const tagsContainer = document.getElementById("tags");

    fetch("files.json")
        .then(response => response.json())
        .then(data => {
            const files = data;
            const allTags = new Set();
            files.forEach(file => file.tags.forEach(tag => allTags.add(tag)));
            allTags.forEach(tag => {
                const tagButton = document.createElement("button");
                tagButton.textContent = tag;
                tagButton.onclick = () => filterByTag(tag);
                tagsContainer.appendChild(tagButton);
            });
            renderFiles(files);
            searchInput.addEventListener("input", () => {
                const query = searchInput.value.toLowerCase();
                const filteredFiles = files.filter(file =>
                    file.name.toLowerCase().includes(query)
                );
                renderFiles(filteredFiles);
            });

            function renderFiles(filesToRender) {
                fileContainer.innerHTML = "";
                filesToRender.forEach(file => {
                    const card = document.createElement("div");
                    card.className = "file-card";
            
                    const img = document.createElement("img");
                    img.src = file.image || "placeholder.png";
                    img.alt = file.name;
            
                    const title = document.createElement("h2");
                    title.textContent = file.name;
            
                    const tagsDiv = document.createElement("div");
                    tagsDiv.className = "tags";
                    file.tags.forEach(tag => {
                        const tagSpan = document.createElement("span");
                        tagSpan.textContent = tag;
                        tagsDiv.appendChild(tagSpan);
                    });
            
                    const description = document.createElement("p");
                    description.className = "description";
                    description.textContent = file.description || "No description available.";
            
                    const link = document.createElement("a");
                    link.textContent = file.free ? "Download" : "Purchase";
                    link.href = file.free ? file.download_url : file.purchase_url;
                    link.className = file.free ? "free" : "paid";
            
                    card.appendChild(img);
                    card.appendChild(title);
                    card.appendChild(tagsDiv);
                    card.appendChild(description);
                    card.appendChild(link);
                    fileContainer.appendChild(card);
                });
            }


            function filterByTag(tag) {
                const filteredFiles = files.filter(file => file.tags.includes(tag));
                renderFiles(filteredFiles);
                document.querySelectorAll("#tags button").forEach(button => {
                    if (button.textContent === tag) {
                        button.classList.add("selected");
                    } else {
                        button.classList.remove("selected");
                    }
                });
            }
        })
        .catch(error => console.error("Error loading files:", error));
});