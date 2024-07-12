const frequencies = require("./frequency")

function calculateNextDueDate(startDate, frequency) {
    const date = new Date(startDate);
    const interval = frequencies[frequency];
    date.setDate(date.getDate() + interval);
    return date;
}


module.exports = {calculateNextDueDate};