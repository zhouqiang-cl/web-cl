function convert_timestamp_to_daytime(timestamp) {
    date = new Date(timestamp * 1000),
    datevalues = date.getFullYear() + "/" + 
                date.getMonth()+1 + "/" +
                date.getDate()
    return datevalues
}