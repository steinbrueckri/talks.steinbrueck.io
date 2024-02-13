import { execSync } from 'child_process';
import * as fs from 'fs';
import {isNotJunk} from 'junk';
import { build } from 'slidev';
import { Eta } from "eta"

const slidedecks: string[] = [];

// functions
function runCommand(command: string) {
  console.log(`Running command: ${command}`);
  execSync(command, { stdio: 'inherit' });
}

console.log('--------------------------------');
console.log('-- Build all slidev decks ...  -');
console.log('--------------------------------');

const slides = fs.readdirSync('./slides').filter(isNotJunk);

// empty dist folder
const directory = './dist/';
if (fs.existsSync(directory)) {
    fs.rmSync(directory, { recursive: true });
    console.log('dist folder deleted!');
} else {
    console.log('dist folder does not exist.');
}

// build all slidedecks with slidev
for (const slide of slides) {
  console.log(`## Build ${slide}`);
  runCommand(`yarn slidev build "slides/${slide}/slides.md" --out "../../dist/${slide}" --base "/${slide}"`);
  slidedecks.push(slide);
}

console.log('--------------------------------');
console.log('-- Build overview page ...     -');
console.log('--------------------------------');

// Render a template
const eta = new Eta({ views: "scripts/templates" });
const res = eta.render("./index", { slidedecks: slidedecks });

// Write the rendered content to a file
fs.writeFile("./dist/index.html", res, (err) => {
    if (err) throw err;
    console.log('File has been saved!');
});
