function shuffle(input) {
    const a = input.split('');
    const n = a.length;

    for(let i = n - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        const tmp = a[i];
        a[i] = a[j];
        a[j] = tmp;
    }
    return a.join('');
}


function OBJPatch(data, feed) {
    if (this.isLast()) {
        return feed.send(data);
    }
    const firstKey = Object.keys(data).pop();
    data[firstKey] = data[firstKey].replace(/[aeuiouy]/gi, '_');
    feed.send(data);
}

function OBJRewrite(input, feed) {
    if (this.isLast()) {
        return feed.send(input);
    }
    const output = {};
    const keys = Object.keys(input).forEach(key => {
        output[key] = shuffle(input[key]);
    });
    feed.send(output);
}


module.exports = {
    OBJPatch,
    OBJRewrite,
};

