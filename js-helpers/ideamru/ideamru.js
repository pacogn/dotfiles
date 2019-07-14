#!/usr/bin/env node
const xml2json = require('xml2json')
const fs = require('fs')
const _ = require('lodash')
// const files = [require('os').homedir()+'/projects/bolt/.idea/workspace.xml']
const projectsFolder = `${require('os').homedir()}/projects`
let i = 1
fs.readdirSync(projectsFolder)
    .map(p => `${projectsFolder}/${p}/.idea/workspace.xml`)
    .filter(p => fs.existsSync(p))
    .forEach(f => {
        try{
            const xml = fs.readFileSync(f, {encoding: 'utf8'})
            const json = JSON.parse(xml2json.toJson(xml))
            const result = json.project
                .component.find(c => c.name === 'editorHistoryManager')
                .entry.map(e => ` ${i++} ${f.replace(/\/\.idea.*/, '')}${e.file.replace('file://$PROJECT_DIR$', '')}:${_.get(e, 'provider.state.caret.line', 0)}`)
                .join('\n')
            console.log(result)
        }catch(e){}
    })
