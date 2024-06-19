# Flutter_Covid-19

# Sample

javascript:(function() {
  function downloadCSV(csv, filename) {
    let csvFile = new Blob([csv], { type: "text/csv" });
    let downloadLink = document.createElement("a");
    downloadLink.download = filename;
    downloadLink.href = window.URL.createObjectURL(csvFile);
    downloadLink.style.display = "none";
    document.body.appendChild(downloadLink);
    downloadLink.click();
    document.body.removeChild(downloadLink);
  }

  function exportTableToCSV(filename) {
    let csv = [];
    let headers = ["Title", "Merged At", "URL", "Labels"];
    csv.push(headers.join(","));

    document.querySelectorAll('.js-issue-row').forEach(row => {
      try {
        let title = row.querySelector('a.h4').textContent.trim();
        let mergedAt = row.querySelector('relative-time').getAttribute('datetime');
        let url = row.querySelector('a[data-hovercard-type="pull_request"]').href;

        let labels = Array.from(row.querySelectorAll('.IssueLabel')).map(label => label.textContent.trim()).join(" | ");

        csv.push([title, mergedAt, url, labels].join(","));
      } catch (error) {
        console.error("Error processing row:", error);
      }
    });

    if (csv.length === 1) {
      alert('No merged pull requests found on this page.');
    } else {
      downloadCSV(csv.join("\n"), filename);
    }
  }

  exportTableToCSV("merged_prs.csv");
})();
