
  
// Function to assign a period period for a given hour (0-23)
function getPeriodForHour(hour) {
  const periods = ["night", "dawn", "day", "dusk", "night"];
  const periodBoundaries = [3, 6, 15, 19, 24]; // End hours for 'night', 'dawn', 'day','dusk' and 'night' again
  // .findIndex returns the first it can - it becomes 'dawn' when it is no longer 3:59
  return periods[periodBoundaries.findIndex(boundary => (boundary >= hour) ) ];
}

// Sets the period for the current time
// Called by body/@onload cf portal-page.xpl
function setTheme() {
  let params = new URLSearchParams(document.location.search);
  let given = params.get('by');
  // if no given, or given = 'now', set theme for now using nullish coalescing operator '??'
  theme = (given === 'now' ? null : given) ?? getPeriodForHour( new Date().getHours() );
  document.getElementById('page').className = theme;
  rewriteInternalLinks(given ?? theme);
}

// Rewriting links marked as 'internal' to retain theme of the moment
function rewriteInternalLinks(theme) {
   // links becomes an Array thanks to spread operator '...'
   let links = [ ...document.getElementsByClassName('internal') ];
   links.forEach(a => setBy(a, theme));
}

// On an anchor, sets or resets the 'by' parameter
function setBy(a, val) {
  let u = new URL(a.href);
  u.searchParams.set('by', val);
  a.href = u.toString(); }

