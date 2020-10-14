<template>
  <div>
<table>
    <tr class="white-space-pre-line" v-for="element in markup_elements">
      <td class="width-10">{{ element.title }}</td>
      <td colspan="2"
           v-if="element.hasOwnProperty('description')">{{ element.description }}</td>
      <td class="width-40"
           v-if="element.hasOwnProperty('code')">{{ element.code }}</td>
      <td class="width-40"
           v-if="element.hasOwnProperty('code')">
        <vue-simple-markdown :source="element.code"></vue-simple-markdown>
      </td>
    </tr>
</table>
  </div>
</template>

<script>

export default {
  name: "MarkdownHelp",
  data () {
    return {

      markup_elements: [
        {title: "heading", code: "# title"},
        {title: "horizontal line", code: "***"},
        {title: "horizontal line", code: "___"},
        {title: "italic", code: "*italic* or _italic_"},
        {title: "link", code: "[ACG](https://www.aircombatgroup.co.uk)"},
        {title: "strong", code: "**strong** or __strong__ "},
        {title: "list", code: "* First\n" +
          "* Second\n"},
        {title: "tables", description: "A table is an arrangement of data with rows and columns, consisting of a single header row, a delimiter row separating the header from the data, and zero or more data rows. Each row must start and end with pipes (|) and it consists of cells containing arbitrary text, in which inlines are parsed, separated by pipes (|). Spaces between pipes and cell content are trimmed. Block-level elements cannot be inserted in a table. "},
        {title: "", code: "| Foo | Bar |\n" +
          "|-----|-----|\n" +
          "| Bam | Baz |\n"},
      ],
    }
  }
}
</script>

<style scoped>

</style>
