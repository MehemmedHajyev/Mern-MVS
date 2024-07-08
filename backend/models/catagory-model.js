class CatagoryModel {
    constructor(row) {
        this.id = row.id;
        this.name = row.name;
        this.code = row.code;
        this.deleted = row.deleted;
        this.parent_id = row.parent_id;

    }
    static map(dbRows) {
        const rows = [];
        for (const row of dbRows) {
            const catagory = new CatagoryModel(row)
            rows.push(catagory)
        }
        return rows;
    }
}


module.exports = CatagoryModel;
